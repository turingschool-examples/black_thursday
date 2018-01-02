require 'csv'
require './lib/merchant.rb'

class MerchantRepository

  def intialize(sales_engine)
    @merchants = []
    merchant_creator_and_storer
  end

  def csv_opener
    CSV.open './data/merchants.csv', headers: true, header_converters: :symbol
  end

  def merchant_creator_and_storer
    csv_opener.each do |merchant|
      @merchants << Merchant.new(merchant, self)
    end
  end

end
