require_relative 'merchant'

class MerchantRepository
  attr_reader :merchant_list
  def initialize(merchant_list)
    @merchant_list = merchant_list
  end

  def all
    merchant_list
  end

  def find_by_id
  end

  def find_by_name
  end

  def find_all_by_name
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
