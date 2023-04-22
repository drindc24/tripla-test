# frozen_string_literal: true

class SleepLog < ApplicationRecord
  belongs_to :user

  validates :clock_in, presence: true
  validates :clock_out, comparison: { greater_than: :clock_in }, if: :clock_out
end
