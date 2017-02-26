require_relative './item_repository'
require_relative './merchant_repository'
require_relative './invoice_repository'
require_relative './invoice_item_repository'
require_relative './transaction_repository'
require_relative './customer_repository'


class SalesEngine

  attr_accessor :items, :merchants, :invoices, :invoice_items, :transactions, :customers

  def initialize(hash)
    @items = ItemRepository.new(hash[:items], self) unless hash[:items].nil?
    @merchants = MerchantRepository.new(hash[:merchants], self) unless hash[:merchants].nil?
    @invoices = InvoiceRepository.new(hash[:invoices], self) unless hash[:invoices].nil?
    @invoice_items = InvoiceItemRepository.new(hash[:invoice_items], self) unless hash[:invoice_items].nil?
    @transactions = TransactionRepository.new(hash[:transactions], self) unless hash[:transactions].nil?
    @customers = CustomerRepository.new(hash[:customers], self) unless hash[:customers].nil?
  end

  def self.from_csv(hash)
    SalesEngine.new(hash)
  end
end


# se = SalesEngine.from_csv({
#   :items     => "./test/fixtures/item_fixture.csv",
#   :merchants => "./test/fixtures/merchant_fixture.csv",
#   :invoices => "./test/fixtures/invoice_fixture.csv",
#   :invoice_items => "./test/fixtures/invoice_items_fixture.csv",
#   :transactions => "./data/transactions.csv"
# })
#
# require "pry"; binding.pry
# p ""
