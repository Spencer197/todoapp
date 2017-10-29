class FactorsController < ApplicationController
    before_action :set_factor, only: [:edit, :update, :show]
    before_action :require_admin, except: [:show, :index]
  
  def new
     @factor = Factor.new
  end
  
  def create
    @factor = Factor.new(factor_params)
    if @factor.save
      flash[:success] = "Factor was successfully created"
      redirect_to factor_path(@factor)
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    if @factor.update(factor_params)
      flash[:success] = "Factor name was updated successfully"
      redirect_to @factor
    else
      render 'edit'
    end
  end
  
  def show
    @factor_todos = @factor.todos.paginate(page: params[:page], per_page: 5)
  end
  
  def index
    @factors = Factor.paginate(page: params[:page], per_page: 5)
  end
  
  private
  
  def factor_params
    params.require(:factor).permit(:name)
  end
  
  def set_factor
    @factor = Factor.find(params[:id])
  end
  
  def require_admin
    if !logged_in? || (logged_in? and !current_user.admin?)#If logged in or (if logged in and current user not(!) admin.).
      flash[:danger] = "Only admin users can perform that action"
      redirect_to factors_path
    end
  end

end