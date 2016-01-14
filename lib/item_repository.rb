require 'csv'
require 'bigdecimal'
require_relative 'item'
require_relative 'merchant_repository'

class ItemRepository
attr_reader :data, :file, :all, :item, :repo

  def inspect
      "#<#{self.class} #{@all.size} rows>"
  end

  def initialize(file)
    @all = []
    @file = file
    data_into_hash(load_data(file))
  end

  def load_data(file)
    @data = CSV.open (file), headers: true, header_converters:
    :symbol
  end

  def data_into_hash(data)
    data.each do |row|
      item_id = row[:id]
      name = row[:name]
      unit_price = convert_to_big_decimal((row[:unit_price]).to_s)
      created_at = row[:created_at]
      updated_at = row[:updated_at]
      description = row[:description]
      merchant_id = row[:merchant_id]

      hash = {:id => item_id,
              :description => description, :merchant_id => merchant_id,
              :name => name,
              :created_at => created_at, :updated_at => updated_at, :unit_price => unit_price}
      @item = Item.new(hash)
      @all << item
    end
  end

  def find_by_id(number)
    all = @all
    all.find do |x|
      x.id == number
    end
  end

  def find_by_name(name)
    @all.find do |x|
      x.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    @all.find_all do |x|
      x.description.downcase == description.downcase
    end
  end

  def find_all_by_price(price)
    price = price.to_s
    price = convert_to_big_decimal(price)
    @all.find_all do |x|
      x.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @all.find_all do |x|
      range.include?(x.unit_price.to_f)
    end
  end

  def convert_to_big_decimal(price)
    BigDecimal.new("#{price[0..-3]}.#{price[-2..-1]}")
  end

  def find_all_by_merchant_id(id)
    @all.find_all do |x|
      x.merchant_id == id
    end
  end
end
