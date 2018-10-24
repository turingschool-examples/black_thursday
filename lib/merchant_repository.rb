require 'pry'

class MerchantRepository
  attr_reader :merchants

  def initialize(csv_merchants)
    @merchants = []
  end

  def create_merchant_array(csv_merchants)
    se.merchants.map do |row|
      row
    end
  end

# iterate over collection of merchants
# each iteration create a merchant object
# push that object onto an empty array

end
