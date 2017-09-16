
require_relative "item_repository"
require_relative "merchant_repository"
require_relative "sales_analyst"

class SalesEngine
  attr_reader :items, :merchants, :invoices

  def self.from_csv(file_names)
    @item_file = file_names[:items]
    @merchant_file = file_names[:merchants]
    SalesEngine.new(@item_file, @merchant_file)
  end

  def initialize(item_csv, merchant_csv, invoice_csv)
    @items = ItemRepository.new(self, item_csv)
    @merchants = MerchantRepository.new(self, merchant_csv)
    @invoices = InvoiceRepository.new(self, invoice_csv)
  end
end
