class CreateEngineers < ActiveRecord::Migration[5.0]
  def change
    create_table :engineers do |t|
      t.string :slack_username, null: false
      t.date :duty_date
      t.boolean :duty_fulfilled, null: false, default: false

      t.timestamps

      t.index :slack_username, unique: true
      t.index :duty_date, unique: true
    end
  end
end
