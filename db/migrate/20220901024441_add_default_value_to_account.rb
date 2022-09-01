class AddDefaultValueToAccount < ActiveRecord::Migration[7.0]
  def up
    change_column :accounts, :balance, :float, :default => 0.0
    change_column :accounts, :active, :boolean, :default => true
  end
  def down

  end
end
