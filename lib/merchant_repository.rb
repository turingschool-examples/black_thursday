require './lib/merchant'
require 'csv'

class MerchantRepository

  attr_reader :merchants

  def initialize(file_path)
    @merchants = []
    load_csv(file_path)
  end

  def load_csv(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol, converters: :numeric ) do |merchant|
      merchants << Merchant.new(merchant.to_h)
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

  def find_all_by_name(name_fragment)
    merchants.find_all do |merchant|
      merchant.name.downcase.include?(name_fragment.downcase)
    end
  end

end