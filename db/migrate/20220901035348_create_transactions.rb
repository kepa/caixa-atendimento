class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :account, null: false, foreign_key: true
      t.string :type
      t.float :value
      t.float :fees

      t.timestamps
    end
  end
end
