require 'pry'
require_relative 'merchant'
require_relative 'create_elements'

class MerchantRepo
  include CreateElements

  attr_reader :merchants,
              :parent

  def initialize(data, parent)
    @merchants = create_elements(data).reduce([]) do |result, merchant|
      result << Merchant.new(merchant)
      result
    end
    @parent = parent
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.map do |merchant|
      return merchant if merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants.map do |merchant|
      return merchant if merchant.name == name
    end
  end

  def find_all_by_name(name)
    @merchants.reduce([]) do |result, merchant|
      if merchant.name == name
        result << merchant
      else
        result
      end
    end
  end

end
