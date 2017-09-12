require_relative 'merchant_repo'
require_relative 'item_repo'
require_relative 'item'
require 'csv'

class SalesEngine

  attr_reader :items, :merchants

  def initialize
    @items = ItemRepository.new
    @merchants = MerchantRepository.new
  end

  def from_csv(file = {})
    contents = CSV.open file., headers: true, header_converters: :symbol
    contents.each do |row|
      id = row[:id]
      name = row[:name]
      description = row[:description]
      unit_price = row[:unit_price]
      created_at =row[:created_at]
      updated_at = row[:updated_at]
      merchant_id = row[:merchant_id]
      @items.items << Item.new({ :id => id, :name => name, :description => description, :unit_price => unit_price, :created_at => created_at, :updated_at => updated_at})
    end
  end


end
