require_relative 'csv_adaptor'
require_relative 'merchant_repo'
require_relative 'item_repo'
require_relative 'invoice_repo'
require_relative 'invoice_item_repo'
require_relative 'transaction_repo'
require_relative 'sales_analyst'


class SalesEngine
  extend CsvAdaptor

  attr_accessor :merchants, :items, :invoices, :invoice_items, :analyst, :transactions

  def initialize(merchant_array, item_array, invoice_array, invoice_item_array, transaction_array)
    @merchants = MerchantRepo.new(merchant_array)
    @items = ItemRepo.new(item_array)
    @invoices = InvoiceRepo.new(invoice_array)
    @invoice_items = InvoiceItemRepo.new(invoice_item_array)
    @transactions = TransactionRepo.new(transaction_array)
    @analyst = SalesAnalyst.new(@merchants, @items, @invoices, @invoice_items, @transactions)
  end

  def self.from_csv(hash)
    merchant_file = hash[:merchants]
    item_file = hash[:items]
    invoice_file = hash[:invoices]
    invoice_item_file = hash[:invoice_items]
    transaction_file = hash[:transactions]

    merchant_array = load_from_csv(merchant_file)
    item_array = load_from_csv(item_file)
    invoice_array = load_from_csv(invoice_file)
    invoice_item_array = load_from_csv(invoice_item_file)
    transaction_array = load_from_csv(transaction_file)
    new(merchant_array, item_array, invoice_array, invoice_item_array, transaction_array)
  end

end



# se = SalesEngine.from_csv({
#   :items     => "./data/invoices.csv"}]
# mr = se.merchants
# merchant = mr.merchant_hashes_to_objects()
# p merchant
