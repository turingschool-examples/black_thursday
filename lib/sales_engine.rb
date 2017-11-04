require 'csv'
require_relative './item_repository'
require_relative './merchant_repository'
require_relative './invoice_repository'
require_relative './transaction_repository'
require_relative './customer_repository'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :transactions,
              :customers,
              :invoice_items

  def initialize(repositories)
    @items = ItemRepository.new(repositories[:items], self)
    @merchants = MerchantRepository.new(repositories[:merchants], self)
    @invoices = InvoiceRepository.new(repositories[:invoices], self)
    @transactions = TransactionRepository.new(repositories[:transactions], self)
    @customers = CustomerRepository.new(repositories[:customers], self)
    @invoice_items = nil
  end

  def self.from_csv(files)
    SalesEngine.new({
      :items => load_csv(files[:items]),
      :merchants => load_csv(files[:merchants]),
      :invoices => load_csv(files[:invoices]),
      :transactions => load_csv(files[:transactions]),
      :customers => load_csv(files[:customers]),
      :invoice_items => load_csv(files[:invoice_items])
    })
  end

  def self.load_csv(file_name)
    CSV.readlines(file_name, headers: true, header_converters: :symbol) do |row|
      row
    end
  end

  def find_items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def find_merchant_by_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def find_all_invoices_by_merchant_id(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end
end
