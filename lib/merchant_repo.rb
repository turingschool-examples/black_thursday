require './lib/merchant'
require 'csv'

class MerchantRepo

  def self.all
  merchants = []
  CSV.foreach('./data/merchants.csv', headers: true, header_converters: :symbol) do |row|
    headers = row.headers
    merchants << Merchant.new(row.to_h)
  end
  merchants
  end

  def self.find_by_id(id)
    self.all.find do |merchant|
      merchant.id == id
    end
  end

  def self.find_by_name(name)
    self.all.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def self.find_all_by_name(name)
    self.all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def self.create(attributes)
    
  end
end
