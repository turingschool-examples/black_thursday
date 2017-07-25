require 'pry'
require './lib/merchant'

class MerchantRepository

  attr_reader :merchants

  def initialize
    @merchants = []
  end

  def all
    # all - returns an array of all known Merchant instances
  end

  def find_by_id(id)
    result = nil
    # find_by_id - returns either nil or an instance of Merchant with a matching ID
    # @merchants.each do |something|
    #   results = something.include(id)
    @merchants.each do |merchant|
      if merchant.id == id
        result = merchant
      end
      # if merchant[:id] == id
      #   results << merchant
    end
    result
  end

  def find_by_name(name)
    # find_by_name - returns either nil or an instance of Merchant having done a case insensitive search
  end

  def find_all_by_name(name)
    # find_all_by_name - returns either [] or one or more matches which contain the supplied name fragment, case insensitive
  end

  def add_data(data)
    # @merchants << Merchant.new(data)
    # @merchant.to_hash
    # @merchants.merge!({data[:id] => Merchant.new(data)})
    # @merchants.merge!({Merchant.new(data).convert_to_hash})
    @merchants << Merchant.new(data.to_hash)
  end


end
# merchant = MerchantRepository.new
# binding.pry
