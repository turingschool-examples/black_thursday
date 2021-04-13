require 'csv'
require_relative 'item_repository'

class SalesEngine
  attr_reader :customers,
              :invoice_items,
              :invoices,
              :items,
              :merchants,
              :transactions,
              :item_repository

  def initialize

    @customers = ('./data/customers.csv')
    @invoice_items = ('./data/invoice_items.csv')
    @invoices = ('./data/invoices.csv')
    @item_repository = ItemRepository.new('./data/items.csv')
    #item repository stores all the objects
    @merchants = ('./data/merchants.csv')
    @transactions = ('./data/transactions.csv')
  end

  #send path, don't make hash. Objects add behavior. see below inside each repository. potentially inheritance, perhaps class method
 # file i/o class.

end
