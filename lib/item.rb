require 'csv'

class Item
  attr_accessor :id, :name, :description, :unit_price, :created_at, :updated_at

  def initialize(item)
    @name = item.fetch(:name)
    @description = item.fetch(:description)
    @unit_price = item.fetch(:unit_price)
    @created_at = item.fetch(:created_at)
    @updated_at = item.fetch(:updated_at)
  end
end

if __FILE__ == $PROGRAM_NAME
  contents = CSV.open "./data/items.csv", headers: true, header_converters: :symbol
  contents.each do |row|
    name = row[:name]
    puts "#{name}"
  end
end
