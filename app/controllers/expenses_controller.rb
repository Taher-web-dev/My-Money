class ExpensesController < ApplicationController
  def show
  end
  def new
    @expense = Expense.new
  end
  def created
  end
end
