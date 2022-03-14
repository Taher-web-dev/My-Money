class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.string :name
      t.float :amount
      t.text :icon, default: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7CF_n_EGfexCyNj7fvlVfPCkUOGSVz7eplg&usqp=CAU'
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
