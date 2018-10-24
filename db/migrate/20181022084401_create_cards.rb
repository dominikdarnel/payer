class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :bank
      t.string :name
      t.string :currency
      t.integer :number, limit: 8
      t.integer :month
      t.integer :year
      t.integer :ccv
      t.integer :amount
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
