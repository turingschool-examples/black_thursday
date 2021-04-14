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
    @customers = './data/customers.csv'
    @invoice_items = './data/invoice_items.csv'
    @invoices = './data/invoices.csv'
    @items = ItemRepository.new('./data/items.csv', self)
    @merchants = './data/merchants.csv'
    @transactions = './data/transactions.csv'
  end
end
