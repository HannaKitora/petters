class CreateCalendars < ActiveRecord::Migration[6.1]
  def change
    create_table :calendars do |t|
      t.integer :entry_id
      t.integer :event_id

      t.timestamps
    end
  end
end
