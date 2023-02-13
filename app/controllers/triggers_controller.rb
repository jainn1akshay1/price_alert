require 'binance'
require 'eventmachine'

class TriggersController < ApplicationController
  before_action :authorize_request

	def create
		@user = User.find(params[:user_id])
		trigger = @user.triggers.create(trigger_params)
		render json: {trigger: trigger}
	end

	def delete
		@user = User.find(params[:user_id])
		delete_user = @user.triggers.find(params[:id]).update(status: "deleted")
		render json: {trigger: "succefully deleted"}
	end


	def send_mail
		# websocket stream data
		logger = Logger.new(STDOUT)

    client = Binance::Spot::WebSocket.new

    
    EM.run do
      onopen = proc { logger.info 'connected to server'  }
      onmessage = proc { |msg, _type| msg }
      onerror   = proc { |e| logger.error e }
      onclose   = proc { logger.info 'connection closed' }

      callbacks = {
        onopen: onopen,
        onmessage: onmessage,
        onerror: onerror,
        onclose: onclose
      }

      client.kline(symbol: 'btcusdt', interval: '1m', callbacks: callbacks)
    end
		# query once and make array data of trigger price
		# if any array element match with created price of trigger and price of wesocket stream price data
 		# Change trigger status created to triggered 
     user_trigger_prices = @current_user.triggers.where(status: "created")
     if user_trigger_prices.pluck(:price).include?(stream_price)
      user_trigger_prices.where(price: "stream_price").update_all(status: "triggered")
      TriggerMailer.price_trigger_email
     end
		# and send mail to user
	end

	def	trigger_params
		params.require(:trigger).permit(:status, :price)
	end
end


