require 'CSV'
require_relative '../lib/item'
require_relative 'repoable'

class ItemRepository
  include Repoable
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Item.new({:id => row[:id], :name => row[:name], :description => row[:description], :unit_price => row[:unit_price], :created_at => row[:created_at], :updated_at => row[:updated_at], :merchant_id => row[:merchant_id]})
    end
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def find_all_with_description(item_description)
    @all.find_all do |item|
      item.description.downcase.include?(item_description.downcase)
    end
  end

  def find_all_by_price(item_price)
    @all.find_all do |item|
      item.unit_price == item_price
    end
  end

  def find_all_by_price_in_range(range)
      min = range.min
      max = range.max
    @all.find_all do |item|
      item.unit_price.to_i.between?(min, max)
    end
  end

  def create(data_hash)
    id = (@all.last.id. + 1)
    @all << Item.new({:id => id,
                      :name => data_hash[:name],
                      :description => data_hash[:description],
                      :unit_price => data_hash[:unit_price],
                      :created_at => Time.now.to_s,
                      :updated_at => Time.now.to_s,
                      :merchant_id => data_hash[:merchant_id]
                      })
  end
  
  def update(id, attributes)
    find_by_id(id).name = attributes[:name]
    find_by_id(id).description = attributes[:description]
    find_by_id(id).unit_price = BigDecimal(attributes[:unit_price])
    find_by_id(id).updated_at = Time.now
  end
end
