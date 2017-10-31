require './lib/merchant'
require 'csv'

class MerchantRepository
  attr_reader :merchants,
              :merchant_store,
              :sales_engine,
              :name,
              :id

  def initialize
    # @merchants = []
  end

  def find_by_id(id)
    @merchants.detect{|merchant| merchant.id == id}
  end

  # def create_merchant(data)
  #   @merchants << Merchant.new(data, my_reference)
  # end

  def create_merchant(data)
    my_reference = self
    @merchant_store = []
    @merchants = data[:merchants]
    merchant_search =  CSV.foreach @merchants, headers: true, header_converters: :symbol do |row|
      @merchant_store << row
      # binding.pry
    end
  end

#   all - returns an array of all known Merchant instances
# find_by_id - returns either nil or an instance of Merchant with a matching ID
# find_by_name - returns either nil or an instance of Merchant having done a case insensitive search
# find_all_by_name

end
