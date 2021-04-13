require 'csv'
require_relative 'item_repository'

class SalesEngine
  attr_reader :customers,
              :invoice_items,
              :invoices,
              :items,
              :merchants,
              :transactions

  def initialize
    @customers = make_hash('./data/customers.csv')
    @invoice_items = make_hash('./data/invoice_items.csv')
    @invoices = make_hash('./data/invoices.csv')
    @items = ItemRepository.new(make_hash('./data/items.csv'))
    @merchants = make_hash('./data/merchants.csv')
    @transactions = make_hash('./data/transactions.csv')
  end

  def make_hash(path)
    hash = {}
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
        hash[row[:id].to_i] = row
    end
    hash
  end
end
