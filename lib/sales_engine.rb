require 'pry'
require_relative "item_repository"
require_relative "merchant_repository"
require_relative "invoice_repository"

class SalesEngine

  attr_accessor   :items,
                  :merchants,
                  :invoices

  def initialize
    @items      = ItemRepository.new(self)
    @merchants  = MerchantRepository.new(self)
    @invoices   = InvoiceRepository.new(self)
  end

  def self.from_csv(repo)
    items_CSV = repo[:items]
    merchants_CSV = repo[:merchants]
    invoices_CSV = repo[:invoices]

    se = SalesEngine.new
    se.items.populate(items_CSV)
    se.merchants.populate(merchants_CSV)
    se.invoices.populate(invoices_CSV)
    return se
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def find_merchant_by_id(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  def find_invoices_for_merchant(merchant_id)
    @invoices.find_all_by_merchant_id(merchant_id)
  end

  def find_merchant_for_invoice(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

end
