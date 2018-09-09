require 'CSV'
require 'pry'
require './lib/merchant'

class MerchantRepository

  def initialize(value_path)
    @merchants = []
    make_merchants(value_path)
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant[:id] == id
    end
  end

  def make_merchants(value_path)
    csv_objects = CSV.open(value_path, headers: true, header_converters: :symbol)
    csv_objects.map do |object|
      object[:id] = object[:id].to_i
      @merchants << object.to_h
     end
  end
end
