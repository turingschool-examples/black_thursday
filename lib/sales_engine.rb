require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'

class SalesEngine
  attr_reader :item_csv_path,
              :merchant_csv_path,
              :invoice_csv_path,
              :items,
              :merchants,
              :invoices

  def initialize(hash)
    @item_csv_path = hash[:items]
    @merchant_csv_path = hash[:merchants]
    @invoice_csv_path = hash[:invoices]
    @items = ItemRepository.new(@item_csv_path, self)
    @merchants = MerchantRepository.new(@merchant_csv_path, self)
    @invoices = InvoiceRepository.new(@invoice_csv_path, self)
  end

  def self.from_csv(hash)
    self.new(hash)
  end

  def route(payload)
    case payload[0]
    when 'merchant items' then find_items_by_merchant_id(payload[1])
    when 'items merchant' then find_merchant(payload[1])
    when 'invoices merchant' then find_merchant(payload[1])
    when 'merchant invoices' then find_invoices_by_merchant_id(payload[1])
    end
  end

  def find_merchant(attribute_used)
    @merchants.find_by_id(attribute_used)
  end

  def find_items_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    @invoices.find_all_by_merchant_id(merchant_id)
  end
end
