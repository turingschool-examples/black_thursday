require './lib/merchant'
require 'CSV'

class MerchantRepo

  def populate_information
    merchants = Hash.new{|h, k| h[k] = [] }
    CSV.foreach('./data/merchants.csv', headers: true, header_converters: :symbol) do |merchant_info|
      merchants[merchant_info[:id]] = Merchant.new(merchant_info)
    end
      merchants
  end
end
