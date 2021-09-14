require './lib/merchant'
require 'csv'

class MerchantRepo

  def all
  merchants = []
  CSV.foreach('./data/merchants.csv', headers: true, header_converters: :symbol) do |row|
    headers = row.headers
    merchants << Merchant.new(row.to_h)
  end
  merchants
  end

  def find_by_id(id)
    all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    all.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  # def create(attributes)
  #
  # end
  #
  # def find_highest_id
  #
  # end
end
