class Api::V1::PortfoliosController < ApplicationController

  def show
    @portfolio = Portfolio.find(params[:id])
    render json: @portfolio
  end

  def create
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

  def update
    @portfolio = Portfolio.find(portfolio_params[:id])
    @portfolio.update(portfolio_params)
    if @portfolio.save
      render json: @portfolio
    else
      render json: {errors: @portfolio.errors.full_messages}, status: 422
    end
  end

  def destroy
    @portfolio = Portfolio.find(params[:id])
    @portfolio.destroy
    render json: {message: "Portfolio Deleted"}
  end

  private

  def portfolio_params
    params.permit(
      :user_id,
      :ticker_id,
      :purchase_amount,
      :purchase_price
    )
  end


end
