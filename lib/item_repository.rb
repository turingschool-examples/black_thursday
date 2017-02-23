require_relative 'item'
require 'pry'

class ItemRepository
  attr_reader :item_contents, :items

  def initialize(item_contents)
    @item_contents  = item_contents
    @items = []
  end

  def make_items
    item_contents.each do |row|
      item = Item.new({:id => row[:id],
        :name => row[:name],
        :description => row[:description],
        :unit_price => row[:unit_price],
        :merchant_id => row[:merchant_id],
        :created_at => row[:created_at],
        :updated_at => row[:updated_at]})
        @items << item
      end
  end

  def find_by_name(name)
    # binding.pry
    #why is select it returning an array?
    items.find{ |item| item.name == name}
  end

  # def from_csv(input_hash)
  #   # contents = CSV.open "data/items.csv"       #headers: true, header_converters: :symbol
  #   # output = "#{:id},#{:name},#{:description},#{:unit_price},#{:merchant_id},#{:created_at},#{:updated_at}"
  #   @items = ItemRepository.new(item_path)
  #   @merchants = MerchantRepository.new
end
