class Api::V1::TickersController < ApplicationController

  def index
    @tickers= Ticker.all
    render json: @tickers
  end

  def show
    @ticker = Ticker.find(params[:id])
    render json: @ticker
  end

end
