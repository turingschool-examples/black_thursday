require './lib/merchant'
require './lib/sales_engine'

class MerchantRepository
  attr_accessor :merchants

  def initialize
    @merchants = []
  end

  def <<(merch_obj)
    @merchants.push(merch_obj)
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(partial)
    matches = @merchants.find_all do |merchant|
      merchant.name.downcase.include?(partial.downcase)
    end
    if matches.nil?
      []
    else
      matches
  end
end

end
