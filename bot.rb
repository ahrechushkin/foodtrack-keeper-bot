require 'telegram/bot'
require './lib/database'

class FoodtrackKeeperBot
  def initialize(token = nil)
    raise ArgumentError.new 'Telegram API token required.' unless token
    @token = token
    Database::Executor.setup
  end 

  def start
    Telegram::Bot::Client.run(@token) do |bot|
      bot.listen do |message|
        case message.text
        when '/start'
          bot.api.sendMessage(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
        else
          bot.api.sendMessage(chat_id: message.chat.id, text: "Error! Available commands: \n /start \n")
        end
      end
    end
  end
end

FoodtrackKeeperBot.new(ENV['API_TOKEN']).start