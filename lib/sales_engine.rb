require_relative "../lib/item_repository"
require_relative "../lib/merchant_repo"
require_relative "../lib/sales_analyst"

class SalesEngine
  attr_reader   :items,
                :merchants

  def initialize(items, merchants)
    @items     = items
    @merchants  = merchants
    # @invoice_path   = invoice_path
  end

  def self.from_csv(file_path)
    item_path      = file_path[:items]
    merchant_path  = file_path[:merchants]
    # invoice_path   = file_path[:invoices]

    SalesEngine.new(item_path, merchant_path)
  end

  def merchants
    MerchantRepo.new(@merchants)
  end

  def items
    ItemRepository.new(@items)
  end

  # def invoices
  #   InvoiceRepo.new(@invoice_path)
  # end

  def analyst
    SalesAnalyst.new(@items, @merchants)
  end
end
