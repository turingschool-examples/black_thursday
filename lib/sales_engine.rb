require 'time'
require 'CSV'
require_relative "../lib/items_repo"
require_relative "../lib/merchant_repo"
require_relative "../lib/sales_analyst"
require_relative "../lib/customer_repo"

class SalesEngine
  attr_reader :merchants,
              :items,
              :customers
  def initialize(merchants, items, customers)
    @merchants = MerchantRepo.new(merchants)
    @items = ItemsRepo.new(items)
    @customers = CustomerRepo.new(customers)
  end

  def self.from_csv(params)
    merchants =  params[:merchants]
    items =   params[:items]
    customers = params[:customers]
    SalesEngine.new(merchants, items, customers)
  end

  def analyst
    SalesAnalyst.new(self)
  end

end
