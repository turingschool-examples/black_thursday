# frozen_string_literal: true
require_relative './repository'
require_relative './merchant'
# holds, and provides methods for finding, merchants
class MerchantRepository
  include Repository
  def initialize(merchants)
    create_repository(merchants, Merchant)
  end

  # expects an array of arrays, containing strings, 1 id, 2 name
  # def input_to_hash(merchants)
  #   binding.pry
  #   merchants.each do |merchant|
  #     binding.pry
  #     attributes = {}
  #     attributes[:id] = merchant[0].to_i
  #     binding.pry
  #     attributes[:name] = merchant[1]
  #     binding.pry
  #     @repository[merchant[0].to_i] = Merchant.new(attributes)
  #     binding.pry
  #   end
  # end

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

  # def create(attributes)
  #   attributes[:id] = (find_highest_id + 1)
  #   @repository[(find_highest_id + 1)] = Merchant.new(attributes)
  # end

  # def update(id, attributes)
  #   attributes[:id] = id
  #   @repository[id] = Merchant.new(attributes)
  # end

  # def delete(id)
  #   @repository[id] = nil
  # end

  def find_all_by_merchant_id(merchant_id)
    @repository.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    attributes[:id] = (find_highest_id + 1)
    if attributes[:created_at] = Time.now.to_s
    else
      attributes[:created_at] = attributes[:created_at].to_s
    end
    if attributes[:updated_at] = Time.now.to_s
    else
      attributes[:updated_at] = attributes[:updated_at].to_s
    end
    merchant = Merchant.new(attributes)
    @repository[merchant.id] = merchant
  end
end
