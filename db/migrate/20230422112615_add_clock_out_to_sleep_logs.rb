class AddClockOutToSleepLogs < ActiveRecord::Migration[7.0]
  def change
    add_column :sleep_logs, :clock_out, :datetime
  end
end
