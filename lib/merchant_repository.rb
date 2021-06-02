require './merchant'
require 'CSV'

class MerchantRepository
  attr_reader :all

  def initialize(path)
    @all = create_merchants(path)
  end

  def create_merchants(path)
    merchants = CSV.read(path, headers: true, header_converters: :symbol)
    merchants.map do |data|
      Merchant.new(data)
    end
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id == 12337011
    end 
  end
end
