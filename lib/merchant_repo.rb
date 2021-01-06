class MerchantRepo
  attr_reader :merchant_list

  def initialize(merchant_list)
    @merchant_list = merchant_list
  end

  def all
    merchant_list
  end

  def find_by_name(name)
    name = nil
  end
end
