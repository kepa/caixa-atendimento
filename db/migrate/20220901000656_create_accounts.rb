class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.float :balance
      t.boolean :active

      t.timestamps
    end
  end
end
