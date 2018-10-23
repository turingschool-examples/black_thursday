require 'csv'
require 'pry'

class MerchantRepository
  attr_reader :merchants_array

  def initialize(file_path)
    @merchants_array = from_csv(file_path)
  end

  def from_csv(file_path)
    raw_merchant_data = CSV.read(file_path, {headers: true, header_converters: :symbol})
    raw_merchant_data.map do |raw_merchant|
      Merchant.new(raw_merchant.to_h)
    end
  end

  def all
    @merchants_array
  end

  def find_by_id(merchant_id)
    @merchants_array.find do |merchant|
      merchant.id == merchant_id
    end
  end

  def find_by_name(merchant_name)
    @merchants_array.find do |merchant|
      merchant.name == merchant_name
    end
  end
end
