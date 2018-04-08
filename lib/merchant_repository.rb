require 'csv'
require './lib/merchant'

class MerchantRepository
  attr_reader :path,
              :merchants

  def initialize(path)
    @path = path
    @merchants = []
    pack_merchants(path)
  end

  def pack_merchants(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |merchant|
    merchants << Merchant.new(merchant)
    end
  end

  def all
    merchants
  end

  def find_by_id(id)
    merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

end
