require 'pry'
require './lib/merchant'

class MerchantRepository

  attr_reader :merchants

  def initialize
    @merchants = []
  end

  def all
    @merchants
  end

  def find_by_id(id)
    result = nil
    @merchants.each do |merchant|
      if merchant.id == id
        result = merchant
      end
    end
    result
  end

  def find_by_name(name)
    result = nil
    @merchants.each do |merchant|
      if merchant.name == name
        result = merchant
      end
    end
    result
  end

  def find_all_by_name(name)
    results = []
    @merchants.each do |merchant|
      down = merchant.name.downcase
      if down.include?(name.downcase)
        results << merchant
      end
    end
    results
  end

  def add_data(data)
    @merchants << Merchant.new(data.to_hash)
  end


end
# merchant = MerchantRepository.new
# binding.pry
