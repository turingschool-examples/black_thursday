require_relative 'item'
require 'csv'
class ItemRepository
  attr_reader :repository

  def initialize(data)
    @repository = {}
    load_csv_file(data)
  end

  def load_csv_file(data)
    CSV.foreach(data, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
      data = row.to_h
      repository[data[:id].to_i] = Item.new(data)
    end
  end

  def all
    repository.values
  end

  def find_by_id(id)
    if repository.keys.include?(id)
      return repository[id]
    end
  end

  def find_by_name(name)
    items = repository.values
    items.each do |item|
      if item.name.downcase == name.downcase
        binding.pry
        return item
      else
        return nil
      end
    end
  end

  def find_all_with_description(description)
    descriptions = []
    items = repository.values
    items.each do |item|
      if item.description.include?(description.downcase)
        descriptions << item
      end
    end
    return descriptions
  end

  def find_all_by_price(price)
    converted_price = BigDecimal.new(price,4)
    prices = []
    items = repository.values
    items.each do |item|
      if item.unit_price == converted_price
        prices << item
      end
    end
    return prices
  end

  def find_all_by_price_in_range(range)
    prices = []
    items = repository.values
    items.each do |item|
      if range.include?(item.unit_price)
        prices << item
      end
    end
    return prices
  end

  def find_all_by_merchant_id(merchant_id)
    merchant = []
    items = repository.values
    items.each do |item|
      if item.merchant_id == merchant_id
        merchant << item
      end
    end
    return merchant
  end
end
