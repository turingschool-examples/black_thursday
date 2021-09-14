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
    result = self.all.find do |merchant|
      merchant.id == id
    end
  end
end
