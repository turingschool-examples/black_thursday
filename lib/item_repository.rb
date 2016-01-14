require 'bigdecimal'
require 'item'
require 'csv_loader'
require 'finder'

class ItemRepository
include CsvLoader
include Finder
attr_reader :all

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def initialize(item_file)
    data_into_hash(load_data(item_file))
  end

  def data_into_hash(data)
    @all ||= data.map do |row|
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
      Item.new(hash)
    end
  end

  def find_all_with_description(description)
    all.find_all { |x| x.description.downcase == description.downcase }
  end

  def find_all_by_price(price)
    price = price.to_s
    price = convert_to_big_decimal(price)
    all.find_all { |x| x.unit_price == price }
  end

  def find_all_by_price_in_range(range)
    all.find_all { |x| range.include?(x.unit_price.to_f) }
  end

  def convert_to_big_decimal(price)
    BigDecimal.new("#{price[0..-3]}.#{price[-2..-1]}")
  end

  def find_all_by_merchant_id(id)
    all.find_all { |x| x.merchant_id == id }
  end
end
