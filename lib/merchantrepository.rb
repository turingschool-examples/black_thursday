class Merchant_Repository
  attr_reader   :merchants

  def initialize
    @merchant_repository
    @merchants = []
  end

  def all
    merchants
  end

  def find_by_id(merchant_id)
    merchants.find do |merchant|
      merchant.id == merchant_id
    end
  end

  def find_by_name(merchant_name)
    merchants.find do |merchant|
      merchant.name.upcase == merchant_name.upcase
    end
  end

  def find_all_by_name(merchant_name)
    merchants.select do |merchant|
      merchant.name.upcase.include?(merchant_name.upcase)
    end
  end

  
end