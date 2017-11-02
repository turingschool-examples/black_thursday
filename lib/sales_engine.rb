require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine
  attr_reader :items,
              :merchants

  def initialize
    @merchants= MerchantRepository.new(self)
    @items = ItemRepository.new(self)
    @invoices = InvoiceRepository.new(self)
  end

  def merchant_loader(data)
    @merchants.create_merchant(data)
  end

  def item_loader(data)
    @items.create_item(data)
  end

  def invoice_loader(data)
    binding.pry
    @invoice.create_invoice(data)
  end

  def self.from_csv(data)
    sales = SalesEngine.new
    sales.item_loader(data[:items])
    sales.merchant_loader(data[:merchants])
    # sales.invoice_loader(data[:invoices]) if nil
    sales
  end

  def find_items_belonging_to_merchants(id)
     items.find_all_by_merchant_id(id)
  end

  def find_merchant_by_id(merchant_id)
     merchants.find_by_id(merchant_id)
  end

end
