class User < ApplicationRecord
  has_many :sleep_logs, dependent: :destroy
  
  validates :name, presence: true
end
