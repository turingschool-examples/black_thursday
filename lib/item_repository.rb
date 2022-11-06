# frozen_string_literal: true

require 'bigdecimal'
require_relative 'item'
require_relative 'general_repo'

# This is the item_repository class
class ItemRepository < GeneralRepo
  def initialize(data, engine)
    super(Item, data, engine)
  end

  def find_by_name(name)
    @repository.find { |item| item.name.casecmp?(name) }
  end

  def find_all_with_description(description)
    @repository.select { |item| clean_string(item.description).casecmp?(clean_string(description)) }
  end

  def find_all_by_price(price)
    @repository.select { |item| item.unit_price_to_dollars == price }
  end

  def find_all_by_price_in_range(range)
    @repository.select { |item| range.include?(item.unit_price_to_dollars) }
  end

  def find_all_by_merchant_id(merchant_id)
    @repository.select { |item| item.merchant_id == merchant_id.to_s }
  end

  def clean_string(desc)
    desc.gsub(/\s+/, '').gsub(/\n+/, '')
  end

  def average_price
    prices = @repository.map { |item | item.unit_price_to_dollars } # dupe
    average(prices.sum, prices.count)
  end

  def average_price_standard_deviation
    prices = @repository.map { |item | item.unit_price_to_dollars } # dupe
    deviation(prices, average_price)
  end

  def golden_items
    std_dev = average_price_standard_deviation
    avg_count = average_price
    all.select do |item|
      deviation_difference(std_dev, item.unit_price_to_dollars, avg_count) > 2
    end
  end
end
