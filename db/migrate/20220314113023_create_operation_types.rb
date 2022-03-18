class CreateOperationTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :operation_types do |t|
      t.references :category, null: false, foreign_key: true
      t.references :expense, null: false, foreign_key: true

      t.timestamps
    end
  end
end
