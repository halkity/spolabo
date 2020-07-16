class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name,         null: false
      t.string :place,        null: false
      t.datetime :start_time, null: false
      t.datetime :end_time,  null: false
      t.references :owner,    foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
