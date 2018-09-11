require 'CSV'
require 'pry'
require_relative './merchant'

class MerchantRepository
  attr_reader   :merchants

  def initialize(value_path)
    @merchants = []
    make_merchants(value_path)
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name == name
    end
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    attributes[:id] = @merchants[-1].id + 1
    new_merchant = Merchant.new(attributes)
      @merchants << new_merchant
      new_merchant
  end

  def update(id, attributes)
    merchant  = find_by_id(id)
    updated_name = attributes[:name]
    merchant.name = updated_name
    merchant
  end

  def delete(id)
    find_merchant  = find_by_id(id)
    @merchants.delete_if do |merchant|
      merchant == find_merchant
    end
  end

  def make_merchants(value_path)
    csv_objects = CSV.open(value_path, headers: true, header_converters: :symbol)
    csv_objects.map do |object|
      @merchants << Merchant.new(object)
    end
  end

end
