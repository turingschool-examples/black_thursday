<<<<<<< HEAD
class SalesEngine


def initialize

end
def self.from_csv(csv_hash)
end

=======
require_relative "../lib/item_repository"
require_relative "../lib/merchant_repo"
require_relative "../lib/invoice_repo"
require_relative "../lib/sales_analyst"

class SalesEngine
  attr_reader   :item_path,
                :merchant_path,
                :invoice_path

  def initialize(item_path, merchant_path, invoice_path)
    @item_path     = item_path
    @merchant_path  = merchant_path
    @invoice_path   = invoice_path
  end

  def self.from_csv(file_path)
    item_path      = file_path[:items]
    merchant_path  = file_path[:merchants]
    invoice_path   = file_path[:invoices]

    SalesEngine.new(item_path, merchant_path, invoice_path)
  end

  def merchants
    MerchantRepo.new(@merchant_path)
  end

  def items
    ItemRepository.new(@item_path)
  end

  def invoices
    InvoiceRepo.new(@invoice_path)
  end

  def analyst
    SalesAnalyst.new(items, merchants, invoices)
  end
>>>>>>> 54383722135aaa5ac8379e0ec48636b533698895
end
