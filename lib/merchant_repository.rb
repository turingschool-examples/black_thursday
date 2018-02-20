require 'csv'

class MerchantRepository
  def initialize(file_path)
  end

  def all
    [] << Merchant.new()
  end
end
