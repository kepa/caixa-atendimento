class AddAccountsTransactions < ActiveRecord::Migration[7.0]
  def self.up
    create_table :accounts_transactions, :id => false do |t|
      t.integer :account_id
      t.integer :transaction_id
    end
  end

  def self.down
    drop_table :accounts_transactions
  end
end
