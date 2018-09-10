require_relative 'merchant'

class MerchantRepository

  attr_reader :merchants

  def initialize
    @merchants = []
  end
  def add_merchant(merchant)
    @merchants << merchant
  end

  def all
    merchants
  end

  def find_by_id(id)
    merchants.find {|merchant| merchant.id == id}
  end


end
