# frozen_string_literal: true

require_relative 'merchant'
require_relative 'general_repo'

# This is the MerchantRepository Class
class MerchantRepository < GeneralRepo
  attr_reader :repository

  def initialize(data, engine)
    super('Merchant', data, engine)
  end

  def find_by_name(name)
    repository.find { |merchant| merchant.name.casecmp?(name) }
  end

  def find_all_by_name(name)
    repository.select { |merchant| merchant.name.downcase.include? name.downcase }
  end

  def number_of_items_per_merchant
    all.map do |merchant|
      merchant.item_count
    end
  end

  def items_per_merchant
    all.map do |merchant|
      merchant._items
    end
  end

  def average_items_per_merchant
    average(number_of_items_per_merchant.sum, all.length).round(2)
  end

  def average_items_per_merchant_standard_deviation
    
  end

  # def average_item_price_for_merchant
  #   average()
  # end
end
