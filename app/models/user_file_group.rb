class UserFileGroup < ApplicationRecord
  has_and_belongs_to_many :user_files, dependent: :nullify
  
  validates :color, :name, presence: true
end
