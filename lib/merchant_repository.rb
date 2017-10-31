require './lib/merchant'
require 'csv'

class MerchantRepository
  attr_reader :merchants,
              :merchant_store,
              :sales_engine,
              :name,
              :id

  def initialize(parent)
    @merchant_store = []
    @sales_engine = parent

  end

  def find_by_id(id)
    @merchant_store.find{|merchant|  merchant.name if merchant.id == id}
  end

  def create_merchant(data)
    my_reference = self
    merchant_search =  CSV.foreach  data[:merchants], headers: true, header_converters: :symbol do |row|
      @merchant_store << Merchant.new(row, my_reference)
      # binding.pry
    end
  end

  def find_by_name(name)
    @merchant_store.find{|merchant|  merchant.name if merchant.name == name}
  end

  def find_all_by_name(name)
    @merchant_store.find_all{|merchant|  merchant.name if merchant.name == name}
  end



#   all - returns an array of all known Merchant instances
# find_by_id - returns either nil or an instance of Merchant with a matching ID
# find_by_name - returns either nil or an instance of Merchant having done a case insensitive search
# find_all_by_name

end
