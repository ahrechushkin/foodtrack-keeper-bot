require './lib/database'

module MenuHelper

  def self.show_menu
    Telegram::Bot::Types::ReplyKeyboardMarkup
              .new(keyboard: [categories.map{|category| category["name"]}], one_time_keyboard: true)
  end

  def self.categories
    db_categories = Database::Executor.get_table('categories')
    db_categories.map{ |category| category }
  end

  def self.items(category_name)
    category_id = Database::Executor.get_table('categories', 'name', category_name)[0]["id"]
    db_items = Database::Executor.get_table('items', 'category_id', category_id)
    db_items.map do |item|
      Telegram::Bot::Types::InlineKeyboardButton.new(text: item["name"], callback_data: item["id"])
    end << Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Close', callback_data: 'close')
  end

  def self.item_info(item_id)
    db_item = Database::Executor.get_table('items', 'id', item_id)[0]
    "#{db_item["name"]} \n #{db_item["description"]} \n Cost: #{db_item["cost"]}"
  end
end
