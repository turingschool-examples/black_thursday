require_relative 'csv_adaptor'
require_relative 'merchant_repo'
require_relative 'item_repo'
require_relative 'sales_analyst'


class SalesEngine
  extend CsvAdaptor

  attr_accessor :merchants, :items, :analyst

  def initialize(merchant_array, item_array, invoice_array)
    @merchants = MerchantRepo.new(merchant_array)
    @items = ItemRepo.new(item_array)
    @invoices = InvoiceRepo.new(invoice_array)
    @analyst = SalesAnalyst.new(@merchants, @items)
  end

  def self.from_csv(hash)
    merchant_file = hash[:merchants]
    item_file = hash[:items]
    invoice_file = hash[:invoices]

    merchant_array = load_from_csv(merchant_file)
    item_array = load_from_csv(item_file)
    invoice_array = load_from_csv(invoice_file)
    new(merchant_array, item_array, invoice_array)
  end

end


# se = SalesEngine.from_csv({
#   :items     => "./data/items.csv",
#   :merchants => "./data/merchants.csv",
# })
# mr = se.merchants
# merchant = mr.merchant_hashes_to_objects()
# p merchant
