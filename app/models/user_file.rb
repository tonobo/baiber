require 'securerandom'

class UserFile < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true

  attr_accessor :user_file

  before_create do
    next unless user_file
    uuid = SecureRandom.uuid
    dir_path = Rails.root.join("public", "uploads", uuid)
    file_path = Rails.root.join("public", "uploads", uuid, user_file.original_filename)
    FileUtils.mkdir_p(dir_path)
    File.open(file_path, "wb") do |f|
      f.write(user_file.read)
    end
    if file_path.to_s[/\.PDF$/i]
      `convert #{file_path} #{dir_path}/convert.jpg`
      self.content = ""
      Dir["#{dir_path}/*.jpg"].each do |file|
        self.content += `tesseract #{file} - 2>/dev/null`
      end
    else
      self.content = `tesseract #{file_path} - 2>/dev/null`
    end
    self.orig = file_path
  end

  def download_url
    self.orig.gsub(/^.*\/public\/uploads\//, "/uploads/")
  end
end
