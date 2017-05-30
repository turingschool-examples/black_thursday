require 'csv'

class Merchant
  def initialize(merchant_data)
    complete_merchant_data = CSV.open "./data/merchants.csv",
    headers: true, header_converters: :symbol
  end


end
