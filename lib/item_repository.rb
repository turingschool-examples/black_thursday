require_relative 'item'
require 'pry'

class ItemRepository
  attr_reader :item_contents, :all

  def initialize(item_contents)
    @item_contents = item_contents
    @all = []
  end

  def make_items
    item_contents.each do |row|
      item = Item.new({:id => row[:id].to_i,
        :name => row[:name],
        :description => row[:description],
        :unit_price => row[:unit_price],
        :merchant_id => row[:merchant_id].to_i,
        :created_at => row[:created_at],
        :updated_at => row[:updated_at]})
        @all << item
      end
  end

  def find_by_id(id)
    all.find{ |item| item.id == id }
  end

  def find_by_name(name)
    all.find{ |item| item.name == name }
  end

  def find_by_description(description)
    all.select{ |item| item.description.downcase == description.downcase }  
  end

  def find_all_by_merchant_id(merchant_id)
    all.select{ |item| item.merchant_id == merchant_id }
  end



  # def from_csv(input_hash)
  #   # contents = CSV.open "data/items.csv"       #headers: true, header_converters: :symbol
  #   # output = "#{:id},#{:name},#{:description},#{:unit_price},#{:merchant_id},#{:created_at},#{:updated_at}"
  #   @all = ItemRepository.new(item_path)
  #   @merchants = MerchantRepository.new
end
