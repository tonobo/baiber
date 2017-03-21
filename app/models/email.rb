require 'net/imap'

class Email < ApplicationRecord
  belongs_to :user

  def self.connections
    @connections ||= {}
  end

  delegate :connections, to: :class

  validates :server, :username, :password, presence: true
  validates :server, uniqueness: { 
    scope: [:user_id, :username],
  }

  has_many :filters, dependent: :destroy

  before_validation do
    self.port ||= 143
    self.ssl = true if self.ssl.nil?
    self.login = 'LOGIN' if self.login.to_s.empty?
  end

  def starttls?
    self.ssl and port == 143 
  end

  def connection
    self.connections[self.id] ||= 
      begin
        ssl = self.ssl
        ssl = false if starttls? 
        s = Net::IMAP.new(self.server, port: self.port, ssl: ssl)
        s.starttls if starttls?
        begin
          s.authenticate(self.login, self.username, self.password)
        rescue
          s.login(self.username, self.password)
        end
        s.examine('INBOX')
        s
      end
  end

  def mailboxes
    return [] unless works?
    connection.list("", "*").map(&:name)
  end

  def works?
    connection.noop
    true
  rescue
    false
  end
end
