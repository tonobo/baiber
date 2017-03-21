class Filter < ApplicationRecord
  belongs_to :email
  
  validates :mailbox, presence: true

  serialize :filters

  after_initialize do
    self.filters ||= {pre: {}, post: //, groups: []}
  end

  def self.mutex
    @mutex ||= {}
  end

  delegate :connection, :user, to: :email

  def since
    if filters[:last_search]
      return [
        "SINCE", 
        (filters[:last_search]-1.day).strftime("%d-%b-%Y")
      ]
    end
    []
  end

  def search_list
    filters.symbolize_keys[:pre].flat_map do |k,v|
      [ k.to_s.upcase, v ] unless v.to_s.empty?
    end.compact
  end

  def file_groups
    UserFileGroup.where(id: filters[:groups].to_a)
  end

  def search(test_run: false)
    ids = []
    mutex.synchronize do
      connection.examine mailbox
      sl = search_list
      sl += since unless test_run
      ids = connection.search sl
    end
    self.class.transaction do
      unless test_run
        filters[:last_search] = Time.now
        save
      end
      mails = ids.map do |x| 
        Mailentry.new(
          filter: self,
          user: self.user,
          content: Base64.encode64(
            connection.fetch(x, "RFC822")[0].try(:attr)["RFC822"]
          )
        )
      end
      post_match mails
    end
  end

  def post_match mails
    r = /#{filters[:post]}/
    matcher = r.respond_to?(:match?) ? :match? : :match
    mails.select do |mail|
      next false if mail.attachments.empty?
      next true if r.__send__(matcher, mail.subject)
      if mail.multipart?
        mail.parts.any? do |part|
          r.__send__(matcher, part.body.to_s) rescue false
        end
      else
        r.__send__(matcher, mail.body.to_s) rescue false
      end
    end
  end

  def mutex
    self.class.mutex[self.email.id] ||= Mutex.new
  end

end
