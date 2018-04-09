# frozen_string_literal: true
require 'pry'
# holds, and provides methods for finding, merchants
class MerchantRepository
  def initialize(merchants)
    @merchants = Hash.new
    input_to_hash(merchants)
  end

  # expects an array of arrays, containing strings, 1 id, 2 name
  def input_to_hash(merchants)
    merchants.each do |merchant|
      attributes = Hash.new
      attributes[merchant[0].split(":")[0].to_sym] = merchant[0].split(":")[1].to_i
      attributes[merchant[1].split(":")[0].to_sym] = merchant[1].split(":")[1]
      @merchants[merchant[0].split(":")[1].to_i] = Merchant.new(attributes)
    end
  end

  def all
    @merchants.values
  end

  def find_by_id(id)
    @merchants[id]
    # @merchants.find do |merchant|
    #   merchant.id == id
    # end
  end

  def find_by_name(name)
    @merchants.values.find do |merchant|
      binding.pry
      merchant.name == name.downcase
    end
  end

  def find_all_by_name(name)
    @merchants.values.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def find_highest_id
    @merchants.max_by{|merchant| merchant.id}
  end

  def create(name)
    @merchants << Merchant.new(id: (find_highest_id.id + 1), name: name)
  end

end
