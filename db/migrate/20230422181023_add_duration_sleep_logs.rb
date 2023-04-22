class AddDurationSleepLogs < ActiveRecord::Migration[7.0]
  def change
    add_column :sleep_logs, :duration, :decimal, precision: 5, scale: 2, default: 0
  end
end
