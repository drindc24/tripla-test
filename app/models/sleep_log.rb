# frozen_string_literal: true

class SleepLog < ApplicationRecord
  belongs_to :user

  validates :clock_in, presence: true
  validates :clock_out, comparison: { greater_than: :clock_in }, if: :clock_out

  before_update :calculate_duration, if: :clock_out_changed?

  private

  def calculate_duration
    self.duration = ((clock_out - clock_in) / 1.hour).round(2)
  end
end
