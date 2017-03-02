
require_relative "item_repository"
require_relative "merchant_repository"
require_relative "invoice_repository"
require_relative "invoice_item_repository"
require_relative "customers_repository"
require_relative "transaction_repository"
require "csv"
require 'pry'

class SalesEngine
  attr_accessor :items,
                :merchants,
                :invoices,
                :invoice_items,
                :transactions,
                :customers

  def self.from_csv(data)
    se = SalesEngine.new
    se.items = ItemRepository.new(data[:items], se)
    se.merchants = MerchantRepository.new(data[:merchants], se)
    unless data[:invoices].nil?
      se.invoices = InvoiceRepository.new(data[:invoices], se)
    end
    se.invoice_items = InvoiceItemRepository.new(se)
    se.invoice_items.from_csv("./data/invoice_items.csv")
    se.transactions = TransactionRepository.new(se)
    se.transactions.from_csv("./data/transactions.csv")
    se.customers = CustomerRepository.new(se)
    se.customers.from_csv("./data/customers.csv")
    se
  end
end