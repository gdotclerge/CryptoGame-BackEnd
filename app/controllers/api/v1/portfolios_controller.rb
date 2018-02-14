class Api::V1::PortfoliosController < ApplicationController

  def show
    @portfolio = Portfolio.find(params[:id])
    render json: @portfolio
  end

  def create
    if (Portfolio.find_by(user_id: portfolio_params[:user_id], ticker_id: portfolio_params[:ticker_id]))
      @portfolio = Portfolio.find_by(user_id: portfolio_params[:user_id], ticker_id: portfolio_params[:ticker_id])
      @user = User.find_by(id: portfolio_params[:user_id])
      purchaseCost = (portfolio_params[:purchase_amount].to_f * portfolio_params[:purchase_price].to_f)
      @portfolio.update_attribute(:purchase_amount, @portfolio.purchase_amount + portfolio_params[:purchase_amount].to_f)
      @portfolio.update_attribute(:purchase_price, @portfolio.purchase_price + portfolio_params[:purchase_price].to_f)
      @user.update_attribute(:unspent_money, @user.unspent_money - purchaseCost)
      render json: @user
    else
      @portfolio = Portfolio.new(portfolio_params)
      @user = User.find_by(id: portfolio_params[:user_id])
      if @portfolio.save
        purchaseCost = (@portfolio.purchase_amount * @portfolio.purchase_price)
        @user.update_attribute(:unspent_money, @user.unspent_money - purchaseCost)
        render json: @user
      else
        render json: {errors: @portfolio.errors.full_messages}, status: 422
      end
    end
  end

  def update
    @portfolio = Portfolio.find(portfolio_params[:id])
    @user = User.find_by(id: portfolio_params[:user_id])
    @portfolio.update(portfolio_params)
    netToUser = (portfolio_params[:purchase_amount].to_f * portfolio_params[:purchase_price].to_f)
    @portfolio.update_attribute(:purchase_amount, @portfolio.purchase_amount - portfolio_params[:purchase_amount].to_f)
    @user.update_attribute(:unspent_money, @user.unspent_money + netToUser)
    if @portfolio.purchase_amount = 0
      @portfolio.destroy
    end
    render json: @user
  end

  def destroy
    @portfolio = Portfolio.find(params[:id])
    @portfolio.destroy
    render json: {message: "Portfolio Deleted"}
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(
      :id,
      :user_id,
      :ticker_id,
      :purchase_amount,
      :purchase_price
    )
  end


end
