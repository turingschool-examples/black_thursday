require 'csv'
require_relative './item'
require 'time'

class ItemRepository
  attr_accessor :items_array
  attr_reader :contents, :engine

  def initialize(path, engine = '')
    @items_path = path
    @items_array = []
    @engine = engine
    pull_csv
    parse_csv
  end

  def pull_csv
    @contents = CSV.open @items_path, headers: true, header_converters: :symbol
  end

  def parse_csv
    @contents.each do |row|
      items_array << Item.new({
        :name        => row[:name],
        :id          => row[:id].to_i,
        :description => row[:description],
        :unit_price  => BigDecimal.new(row[:unit_price].to_i) / 100,
        :created_at  => Time.parse(row[:created_at]),
        :updated_at  => Time.parse(row[:updated_at]),
        :merchant_id => row[:merchant_id].to_i
      }, self)
    end
  end

  def all
    items_array
  end

  def find_by_id(find_id)
    items_array.find do |instance|
      instance.id == find_id
    end
  end

  def find_by_name(find_name)
    items_array.find do |instance|
      instance.name.downcase == find_name.downcase
    end
  end

  def find_all_with_description(find_fragment)
    items_array.find_all do |instance|
      instance.description.downcase.include?(find_fragment.downcase)
    end
  end

  def find_all_by_price(find_price)
    items_array.find_all do |instance|
      instance.unit_price == find_price
    end
  end

  def find_all_by_price_in_range(find_range)
    items_array.find_all do |instance|
       find_range.include?(instance.unit_price)
    end
  end

  def find_all_by_merchant_id(find_id)
    items_array.find_all do |instance|
      instance.merchant_id == find_id
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
