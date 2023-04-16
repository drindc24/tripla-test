# frozen_string_literal: true

class CreateSleepLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :sleep_logs do |t|
      t.integer :user_id
      t.datetime :clock_in

      t.timestamps
    end
  end
end
