require_relative '../lib/item_repository.rb'
require_relative '../lib/item.rb'
require_relative '../lib/merchant_repository.rb'
require_relative '../lib/merchant.rb'
require_relative '../lib/invoice_repository.rb'
require_relative '../lib/invoice.rb'
require_relative '../lib/transaction.rb'
require_relative '../lib/transaction_repository.rb'

class SalesEngine
  attr_reader :items, :merchants, :invoices, :transactions

  def initialize(files)
    @items = ItemRepository.new(files[:items], self)
    @merchants = MerchantRepository.new(files[:merchants], self)
    @invoices = InvoiceRepository.new(files[:invoices], self)
    @transactions = TransactionRepository.new(files[:transactions], self)
  end

  def self.from_csv(files)
    SalesEngine.new(files)
  end

  def find_merchant_by_id(id)
    @merchants.find_by_id(id)
  end

  def find_all_items_by_merchant_id(id)
    @items.find_all_by_merchant_id(id)
  end

  def find_all_invoices_by_merchant_id(id)
    @invoices.find_all_by_merchant_id(id)
  end

  def find_all_transactions_by_invoice_id(id)
    @transactions.find_all_by_invoice_id(id)
  end

  def analyst
    SalesAnalyst.new(self)
  end

end
