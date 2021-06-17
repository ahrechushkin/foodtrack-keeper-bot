require 'telegram/bot'
require './lib/database'
require './lib/menu_helper'
require 'pry'
class FoodtrackKeeperBot
  def initialize(token = nil)
    raise ArgumentError.new 'Telegram API token required.' unless token
    @token = token
    Database::Executor.setup
  end 

  def start
    Telegram::Bot::Client.run(@token) do |bot|
      bot.listen do |message|
        puts message
        case message
        when Telegram::Bot::Types::Message
          case message.text
          when '/start'
            bot.api.sendMessage(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}, what do you want?")
            kb = [
              Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Menu', callback_data: 'menu')
            ]
            markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
            bot.api.send_message(chat_id: message.chat.id, text: 'Make a choice', reply_markup: markup)
          else
            begin
              items = MenuHelper.items(message)
              markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: items)
              bot.api.send_message(chat_id: message.chat.id, text: 'Make a choice', reply_markup: markup)
            rescue => e
              puts e.message
              bot.api.sendMessage(chat_id: message.chat.id, text: "#{message.from.first_name}, i don't know what is it...")
            end
          end
        when Telegram::Bot::Types::CallbackQuery
          case message.data
          when 'menu'
            menu = MenuHelper.show_menu
            question = 'Chose a category'            
            bot.api.send_message(chat_id: message.message.chat.id, text: question, reply_markup: menu)
          when 'close'
            bot.api.send_message(chat_id: message.message.chat.id, text: "Ok! Type /start to open menu")
          else
            begin
              item_info = MenuHelper.item_info(message.data)
              bot.api.sendMessage(chat_id: message.message.chat.id, text: item_info)
            rescue => e
              puts e.message
              bot.api.sendMessage(chat_id: message.message.chat.id, text: "Something went wrong")
            end
          end
        else
          puts message.inspect
        end
        end
      end
    end
end

FoodtrackKeeperBot.new(ENV['API_TOKEN']).start