require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'transaction_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'

class SalesEngine
  attr_reader :item_csv_path,
              :merchant_csv_path,
              :invoice_csv_path,
              :items,
              :merchants,
              :invoices,
              :transactions,
              :invoice_items,
              :customers

  def initialize(hash)
    get_csv_paths(hash)
    @items = ItemRepository.new(@item_csv_path, self)
    @merchants = MerchantRepository.new(@merchant_csv_path, self)
    @invoices = InvoiceRepository.new(@invoice_csv_path, self)
    @transactions = TransactionRepository.new(@transaction_csv_path, self)
    @invoice_items = InvoiceItemRepository.new(@invoice_items_csv_path, self)
    @customers = CustomerRepository.new(@customer_csv_path, self)
  end

  def get_csv_paths(hash)
    @item_csv_path = hash[:items]
    @merchant_csv_path = hash[:merchants]
    @invoice_csv_path = hash[:invoices]
    @transaction_csv_path = hash[:transactions]
    @invoice_items_csv_path = hash[:invoice_item]
    @customer_csv_path = hash[:customers]
  end

  def self.from_csv(hash)
    new(hash)
  end

  def route(payload)
    case payload[0]
    when 'merchant items' then find_items_by_merchant_id(payload[1])
    when 'items merchant' then find_merchant(payload[1])
    when 'invoices merchant' then find_merchant(payload[1])
    when 'merchant invoices' then find_invoices_by_merchant_id(payload[1])
    when 'invoice items' then find_items_by_invoice_id(payload[1])
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

  def find_items_by_invoice_id(invoice_id)
    item_ids = @invoice_items.find_all_by_invoice_id(invoice_id).map(&:item_id)
    item_ids.map { |item_id| @items.find_by_id(item_id) }
  end
end
