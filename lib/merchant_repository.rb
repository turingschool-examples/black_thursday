require_relative 'sales_engine'
require_relative 'merchant'
require 'pry'
class MerchantRepository
# Responsible for holding and searching our Merchant instances.

attr_reader :merchants, :merchant_objects

  def initialize(merchants)
    @merchants = merchants
    @merchant_objects = []
    create_all
  end

  def create_all
    @merchants.each do |merchant|
      @merchant_objects << Merchant.new(merchant)
    end
  end

  def all
    @merchant_objects
  end

  def find_by_id(id)
    @merchant_objects.find do |merchant|
      id == merchant.id
    end
  end

  def find_by_name(name)
    @merchant_objects.find do |merchant|
      name == merchant.name
    end
  end

  def find_all_by_name(name)
    @merchant_objects.find_all do |merchant|
      merchant.name.include?(name)
    end
  end

  def create(attributes)
    highest_id = @merchant_objects.max_by { |merchant| (merchant.id).to_i }
    attributes[:id] = (((highest_id.id).to_i) + 1).to_s
    @merchant_objects << Merchant.new(attributes)
  end

  def update_id(id, attributes)
    merchant = find_by_id(id)
    # 
    # update the Merchant instance with the corresponding id with the provided attributes. Only the merchant’s name attribute can be updated.
  end

  def delete(id)
    merchant = find_by_id(id)
    @merchant_objects.delete(merchant)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
