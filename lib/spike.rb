require 'csv'

class SalesEngine
  attr_reader :items

  def initialize(input_csv_files)
    @items = ItemRepository.new(input_csv_files[:items])
  end
end

class ItemRepository
  attr_reader :items

  def initialize(csv)
    @items = csv.collect { |i| Item.new(i)}
  end

  # item_contents = CSV.open "./data/items.csv", headers: true, header_converters: :symbol
  # item_contents.each do |row|
  #   name = row[:name]
  #   description = row[:description]
  #   unit_price = row[:unit_price]
  # end
end

class Item
  attr_reader :name, :description, :unit_price, :created_at, :updated_at, :merchant_id
  def initialize(params)
  @name = params[0]
  @description = params[1]
  @unit_price = params[2]
  @created_at = Time.now
  @updated_at = Time.now
  @merchant_id = 0
  end

end
