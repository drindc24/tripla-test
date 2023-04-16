# frozen_string_literal: true

class SleepLog < ApplicationRecord
  belongs_to :user

  validates :clock_in, presence: true
end
