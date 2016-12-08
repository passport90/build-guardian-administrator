class CreateEngineers < ActiveRecord::Migration[5.0]
  def change
    create_table :engineers do |t|
      t.string :name
      t.date :duty_date
      t.boolean :duty_fulfilled

      t.timestamps
    end
  end
end
