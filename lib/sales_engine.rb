require 'csv'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

require_relative '../lib/invoice_item_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/customer_repository'
# do some tests guy
class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(data_files)
    @items = ItemRepository.new(data_files, self)
    @merchants = MerchantRepository.new(data_files, self)

    @invoice_items = InvoiceItemRepository(data_files, self)
    @transactions = TransactionRepository(data_files, self)
    @customers = CustomerRepository(data_files, self)
  end

  def self.from_csv(data_files)
    SalesEngine.new(data_files)
  end

  def merchant_output(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  def item_output(merch_id)
    @items.find_all_by_merchant_id(merch_id)
  end
end
