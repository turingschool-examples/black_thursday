require 'csv'
require 'pry'
require_relative 'item'

class ItemRepository

  attr_reader :all, :engine
  def initialize(item_csv_data, engine ="")
    @all = []
    create_item_instances(item_csv_data)
    @engine = engine
  end

  def create_item_instances(data)
    CSV.foreach(data, headers: true, header_converters: :symbol) do |row|
      all << Item.new({id: row[:id], name: row[:name], description: row[:description], unit_price: row[:unit_price], created_at: row[:created_at], updated_at: row[:updated_at], merchant_id: row[:merchant_id]}, self)
    end
  end
  
  def find_by_id(id_num)
    all.find { |item| item.id == id_num }
  end

  def find_by_name(name)
    all.find { |item| item.name.downcase == name.downcase}
  end
  
  def find_all_by_description(fragment)
    all.select { |item| item.description.downcase.include?(fragment.downcase)}
  end
  
  def find_all_by_price(price)
    all.select { |item| item.unit_price == price}
  end

  def find_all_by_merchant_id(merchant_id_num)
    all.select { |item| item.merchant_id == merchant_id_num }
  end
  
end


