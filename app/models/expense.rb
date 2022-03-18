class Expense < ApplicationRecord
  belongs_to :user
  has_many :operation_types
  has_many :categories, through: :operation_types
  validates :name, presence: true
  validates :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }

  def create_category_type(categories_list)
    categories_list.each do |cat|
      new_operation = OperationType.new(expense: self, category_id: cat)
      new_operation.save!
    end
  end
end
