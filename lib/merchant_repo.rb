require_relative 'merchant'

class MerchantRepository
  attr_reader :merchant_list
  def initialize(merchant_list)
    @merchant_list = merchant_list
  end

  def all
    merchant_list
  end

  def find_by_id(id)
    merchant_list.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    merchant_list.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(fragment)
    merchant_list.find_all do |merchant|
      merchant.name.downcase.include?(fragment.downcase)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
