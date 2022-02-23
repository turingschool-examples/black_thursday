require 'csv'
require_relative 'merchant'

class MerchantRepository
  def initialize(csv)
    @all_merchants = Merchant.read_file(csv)
  end

  def all
    @all_merchants
  end
end
