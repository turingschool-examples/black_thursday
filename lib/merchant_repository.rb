# frozen_string_literal: true

require_relative './merchant'
# holds, and provides methods for finding, merchants
class MerchantRepository
  attr_reader :all
  def initialize(merchants)
    @repository = {}
    input_to_hash(merchants)
    @all = @repository.values
  end

  # expects an array of arrays, containing strings, 1 id, 2 name
  def input_to_hash(merchants)
    merchants.each do |merchant|
      attributes = {}
      attributes[:id] = merchant[0].to_i
      attributes[:name] = merchant[1]
      @repository[merchant[0].to_i] = Merchant.new(attributes)
    end
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

  def find_by_id(id)
    @repository[id]
  end

  def find_by_name(merchant_name)
    # binding.pry
    @repository.values.find do |merchant|
      merchant.name.casecmp(merchant_name).zero?
    end
  end

  def find_all_by_name(name)
    @repository.values.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def find_highest_id
    highest_merchant = @repository.values.max_by(&:id)
    highest_merchant.id
  end

  def create(attributes)
    attributes[:id] = (find_highest_id + 1)
    @repository[(find_highest_id + 1)] = Merchant.new(attributes)
  end

  def update(id, attributes)
    attributes[:id] = id
    @repository[id] = Merchant.new(attributes)
  end

  def delete(id)
    @repository[id] = nil
  end

  def find_all_by_merchant_id(merchant_id)
    @repository.find_all do |item|
      item.merchant_id == merchant_id
    end
  end
end
