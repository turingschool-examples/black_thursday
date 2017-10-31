require './lib/merchant'

class MerchantRepository

  attr_reader :merchants, :parent

  def initialize(parent)
    @merchants = []
    @parent = parent
  end

  def create_merchant(data)
    merchants << Merchant.new(data, self)
  end

  def find_by_id(id)
    merchants.find do |merchant|
      merchant.id == id
    end
  end

  def all
    return merchants
  end

  def count
    merchants.count
  end

  def find_by_name(name)
    merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

end


# find_by_id - returns either nil or an instance of Merchant with a matching ID
# find_by_name - returns either nil or an instance of Merchant having done a case insensitive search
# find_all_by_name - returns either [] or one or more matches which contain the supplied name fragment, case insensitive
