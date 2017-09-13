require_relative 'merchant'

class MerchantRepository
  def initialize(merchant_list)
    @merchant_list = merchant_list
  end
  
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
  end

  def find_by_id
  end

  def find_by_name
  end

  def find_all_by_name
  end
end
