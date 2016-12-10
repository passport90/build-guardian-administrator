class AddDutyOwedColumnToEngineers < ActiveRecord::Migration[5.0]
  def change
    add_column :engineers, :duty_owed, :boolean, null: false, default: false
  end
end
