
require_relative "item_repository"
require_relative "merchant_repository"
require_relative "invoice_repository"
require_relative "sales_analyst"

class SalesEngine
  attr_reader :items, :merchants, :invoices

  def self.from_csv(file_names)
    @item_file = file_names[:items]
    @merchant_file = file_names[:merchants]
    @invoice_file = file_names[:invoices]
    SalesEngine.new(@item_file, @merchant_file, @invoice_file)
  end

  def initialize(item_csv, merchant_csv, invoice_csv)
    @items = ItemRepository.new(self, item_csv)
    puts items.all[0].item_repository
    @merchants = MerchantRepository.new(self, merchant_csv)
    puts merchants.all[0].merchant_repository
    @invoices = InvoiceRepository.new(self, invoice_csv)
    puts invoices.all[0].invoice_repository
  end
end
