class Mailentry < ApplicationRecord
  belongs_to :user
  belongs_to :filter
  belongs_to :user_file

  validates :message_id, uniqueness: true, presence: true

  default_scope { select(Mailentry.columns_hash.keys - ["content"]) } 

  scope :with_content, ->{ select(Mailentry.columns_hash.keys) }

  attr_accessor :raw

  def raw
    unless @raw.is_a? Mail
      @raw = Mail.new(Base64.decode64(self.content))
    end
    @raw
  end

  def content
    unless self.attributes.key?("content")
      reload
    end
    super
  end


  delegate :body, :parts, :subject, :attachments, :multipart?, to: :raw

  before_validation on: :create do
    self.user_file = create_user_file
  end

  before_validation do
    self.received_at ||= raw.date
    self.message_id ||= raw.message_id
  end

  def create_user_file
    a = raw.attachments.find do |x|
      x.filename[/(pdf|jpe?g)$/i]
    end
    x = UserFile.create!(
      mailentry: a, 
      user: self.user, 
      name: subject
    )
    x.user_file_groups << filter.file_groups
    x
  end
end
