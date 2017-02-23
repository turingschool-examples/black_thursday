require_relative "merchant"

class MerchantRepository
  attr_reader :merchant_repository

  def initialize(merchant_csv, parent)
    @merchant_csv = merchant_csv
    @parent = parent
  end

  def make_merchant_repository
    @merchant_repository = {}
    @merchant_csv.read.each do |merchant|
      @merchant_repository[merchant[:merchant_id]] = Merchant.new(merchant, self)
    end
    return self
  end

end
