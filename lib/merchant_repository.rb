require_relative 'merchant'
require 'pry'

class MerchantRepository
  def initialize(csv_file)
  
    @merchant_repo = csv_file.map do |merchant|

      Merchant.new(merchant)
    end
  end

end
