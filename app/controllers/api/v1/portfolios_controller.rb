class Api::V1::PortfoliosController < ApplicationController

  def show
    @portfolio = Portfolio.find(params[:id])
    render json: @portfolio
  end

  def create
    @portfolio = Portfolio.new(portfolio_params)
    if @portfolio.save
      render json: @portfolio
    else
      render json: {errors: @portfolio.errors.full_messages}, status: 422
    end
  end

  def update
    @portfolio = Portfolio.find(params[:id])
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
    params.require(:portfolio).permit(
      :user_id,
      :ticker_id,
      :purchase_amount,
      :purchase_price
    )
  end


end
