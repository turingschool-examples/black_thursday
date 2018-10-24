require 'pry'

class MerchantRepository
  attr_reader :merchants

  def initialize(csv_merchants)
    @merchants = []
    create_merchant
  end

  # def create_merchant(csv_merchants)
  #   merchants.map do |row|
  #     row
  #   end
  # end

# iterate over collection of merchants
# each iteration create a merchant object
# push that object onto an empty array

end
