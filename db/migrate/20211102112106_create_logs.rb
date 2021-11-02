class CreateLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :logs do |t|
      t.string :log_data
      t.string :source_ip
      t.string :destination_ip
      t.string :event_id
      t.timestamps
    end
  end
end
