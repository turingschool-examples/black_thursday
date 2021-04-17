require_relative 'merchant'
require 'CSV'

class MerchantRepo
  attr_reader :merchants,
              :data

  def initialize(path, engine)
    @repo = engine
    @merchants = []
    populate_information(path)
  end

  def populate_information(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |merchant_info|
      @merchants << Merchant.new(merchant_info, self)
    end
  end

  def all
    @merchants
  end

  def add_merchant(merchant) 
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

  def find_all_by_name(name_fragment) 
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name_fragment.downcase)
    end
  end

  def create(attributes)
    merchant = Merchant.new(attributes, @engine)
    max = @merchants.max_by do |merchant|
      merchant.id
    end
    merchant.id = max.id + 1
    add_merchant(merchant)
    return merchant
  end

  def update(id, attributes)
    new_merchant = find_by_id(id)
    return if !new_merchant
    new_merchant.name = attributes[:name]
    return new_merchant
  end

  def delete(id)
    @merchants.delete(find_by_id(id))
  end
end
