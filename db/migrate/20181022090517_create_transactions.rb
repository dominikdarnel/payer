class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.references :initiated_by, index: true, foreign_key: { to_table: :users }
      t.references :from_account, index: true, foreign_key: { to_table: :accounts }
      t.references :to_account, index: true, foreign_key: { to_table: :accounts }

      t.timestamps
    end
  end
end
