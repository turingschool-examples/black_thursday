require_relative  "../lib/item_repository"
require_relative  "../lib/merchant_repository"
require_relative  "../lib/invoice_repository"
require_relative  "../lib/transactions_repository"
require_relative  "../lib/invoice_item_repository"
require "csv"
require "pry"

class SalesEngine

  attr_reader :items,
              :merchants,
              :invoices,
              :transactions,
              :invoice_items

  def initialize(files_to_load)
      @items = ItemRepository.new(files_to_load[:items], self)
      @merchants = MerchantRepository.new(files_to_load[:merchants], self)
      @invoices = InvoiceRepository.new(files_to_load[:invoices], self)
      @transactions = TransactionRepository.new(files_to_load[:transactions], self)
      @invoice_items = InvoiceItemRepository.new(files_to_load[:invoice_items], self)

  end

  def self.from_csv(files_to_load)
      self.new(files_to_load)
  end

  def find_items_by_merchant_id(merchant_id_input)
    items.find_all_by_merchant_id(merchant_id_input)
  end

  def find_merchant_by_id(merchant_id_input)
    merchants.find_by_id(merchant_id_input)
  end

  def merchant_count
    merchants.merchant_count
  end

  def item_count
    @items.item_count
  end

  def all_merchants
    merchants.all
  end

  def all_items
    items.all
  end

end
