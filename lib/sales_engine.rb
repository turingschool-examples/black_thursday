require_relative "item_repository"
require_relative "merchant_repository"
require_relative "invoice_repository"

class SalesEngine
attr_reader :files, :items, :merchants, :invoices

  def self.from_csv(files)
    SalesEngine.new(files)
  end

  def initialize(files)
    load_files(files)
    relationships
  end

  def load_files(files)
    @merchants = MerchantRepository.new(files[:merchants])
    @items = ItemRepository.new(files[:items])
    @invoices = InvoiceRepository.new(files[:invoices])
  end

  def relationships
    merchant_to_item_relationship
    item_to_merchant_relationship
    invoice_to_merchant_relationship
    merchant_to_invoice_relationship
  end

  def invoice_to_merchant_relationship
    invoices.all.each do |invoice|
      invoice.merchant = merchants.find_by_id(invoice.merchant_id)
    end
  end

  def merchant_to_invoice_relationship
    merchants.all.each do |merchant|
      merchant.invoices = invoices.find_all_by_merchant_id(merchant.id)
    end
  end

  def merchant_to_item_relationship
    merchants.all.each do |merchant|
      merchant.items = items.find_all_by_merchant_id(merchant.id)
    end
  end

  def item_to_merchant_relationship
    items.all.each do |item|
      item.merchant = merchants.find_by_id(item.merchant_id)
    end
  end

end
