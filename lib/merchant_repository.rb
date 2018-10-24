require './lib/repository'
class MerchantRepository < Repository

  def initialize
    @merchants = []
    @collection = @merchants
  end

  def add_merchant(merchant)
    @merchants << merchant
  end

  def merchants
    @merchants
  end

  def create(name)
    add_merchant(Merchant.new({id: find_new_id, name: name}))
  end

  def find_all_by_name(name)
     merchants_by_name = []
    @merchants.find_all do |merchant|
      if merchant.name.downcase.include?(name)
      merchants_by_name << merchant
      end
    end
    merchants_by_name
  end
end
