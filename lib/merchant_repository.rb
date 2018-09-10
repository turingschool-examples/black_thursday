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

  def find_by_name(name)
    merchants.find {|merchant| merchant.name.downcase == name}
  end

  def find_all_by_name(name)
    merchants.find_all {|merchant| merchant.name.downcase == name}
  end


end
