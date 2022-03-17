class ExpensesController < ApplicationController
  def show
  end
  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(**expense_params, user: current_user)
    if @expense.save
      @expense.create_category_type(category_params)
      redirect_to "/expenses/#{category_params[0]}", success: 'Transaction Added successfully'
    else 
      redirect_to "/expenses/new", alert: 'Transaction could not be created!'
    end
  end

  private 
  def expense_params
    params.require(:expense).permit(:name, :amount, :icon)
  end

  def category_params
    input_params = params.require(:expense)
    filtred_params = []
    input_params.each do |key,val|
      if !['name', 'amount', 'icon'].include? key
        if val == "1"
          filtred_params.push(key.to_i)
        end
      end
    end
    return filtred_params
  end
end
