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
    merchant = @merchants.find do |merchant|
     merchant.id == id
    end
  end

  def find_by_name(name)
    merchant = @merchants.find do |merchant|
      merchant.name == name
    end
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include? name.downcase
    end
  end

  def make_merchants(value_path)
    csv_objects = CSV.open(value_path, headers: true, header_converters: :symbol)
    csv_objects.map do |object|
      @merchants << Merchant.new(object)
     end
  end
end
