require 'securerandom'

class UserFile < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :user_file_groups, dependent: :destroy

  default_scope { order(created_at: :desc) }

  has_many :mailentries, dependent: :destroy
  
  validates :name, presence: true
  attr_accessor :user_file
  attr_accessor :mailentry

  before_create do
    next unless mailentry
    uuid = SecureRandom.uuid
    dir_path = Rails.root.join("public", "uploads", uuid)
    file_path = Rails.root.join("public", "uploads", uuid, mailentry.filename)
    FileUtils.mkdir_p(dir_path)
    File.open(file_path, "wb") { |f| f.write(mailentry.body.decoded) }
    convert(file_path, dir_path)
    self.orig = file_path
  end

  before_create do
    next unless user_file
    uuid = SecureRandom.uuid
    dir_path = Rails.root.join("public", "uploads", uuid)
    file_path = Rails.root.join("public", "uploads", uuid, user_file.original_filename)
    FileUtils.mkdir_p(dir_path)
    File.open(file_path, "wb") { |f| f.write(user_file.read) }
    convert(file_path, dir_path)
    self.orig = file_path
  end

  def download_url
    self.orig.gsub(/^.*\/public\/uploads\//, "/uploads/")
  end
  
  def convert(file_path, dir_path)
    if file_path.to_s[/\.PDF$/i]
      `convert #{Shellwords.escape(file_path)} #{dir_path}/convert.jpg`
      self.content = ""
      Dir["#{dir_path}/*.jpg"].each do |file|
        self.content += `tesseract #{Shellwords.escape(file)} - 2>/dev/null`
      end
      self.content += `pdftotext #{Shellwords.escape(file_path)} -`
    else
      self.content = `tesseract #{Shellwords.escape(file_path)} - 2>/dev/null`
    end
  end
end
