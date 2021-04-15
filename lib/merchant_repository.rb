require './lib/merchant'
require 'CSV'

class MerchantRepo
  attr_reader :all

  def initialize
    @merchants = []
  end

  def populate_information
    merchants = Hash.new{|h, k| h[k] = [] }
    CSV.foreach('./data/merchants.csv', headers: true, header_converters: :symbol) do |merchant_info|
      merchants[merchant_info[:id]] = Merchant.new(merchant_info)
    end
    merchants.each_value do |merchant|
      @merchants << merchant
    end
  end

  def all
    @merchants
  end

  def add_merchant(merchant) #helper method for merchant class (later, add new merchant)
    @merchants << merchant
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name_fragment) #advocate for this place holder!
    name_matches = []
    @merchants.find_all do |merchant|
      if merchant.name.downcase.include?(name_fragment.downcase)
        name_matches << merchant
      end
    end
  end

  def create(attributes)
    merchant = Merchant.new(attributes)
    max = @merchants.max_by do |merchant|
      merchant.id
    end
    merchant.id = max.id + 1
    return merchant
  end

  def update(id, attributes)
    new_merchant = find_by_id(id)
    new_merchant.name = attributes[:name]
    return new_merchant
  end

  def delete(id)
  merchant = find_by_id(id)
  @merchants.delete(merchant)
  end


end
