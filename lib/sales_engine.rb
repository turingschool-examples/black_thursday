require 'CSV'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'

class SalesEngine
  attr_reader :items, :merchants, :invoices, :invoice_items, :transactions, :customers

  def initialize(file_location)
    @item_repository = ItemRepository.new(file_location[:items], self).create_repo
    @merchant_repository = MerchantRepository.new(file_location[:merchants], self).create_repo
    @invoice_repository = InvoiceRepository.new(file_location[:invoices], self).create_repo
    @invoice_item_repository = InvoiceItemRepository.new(file_location[:invoice_items], self).create_repo
    @customer_repository = CustomerRepository.new(file_location[:customers], self).create_repo
    @transaction_repository = TransactionRepository.new(file_location[:transactions], self).create_repo
  end

  def self.from_csv(file_location)
    SalesEngine.new(file_location)
  end

  def merchants
    @merchant_repository
  end

  def find_merchant_by_id(id)
    @merchant_repository.find_by_id(id)
  end

  def items
    @item_repository
  end

  def find_item_by_id(id)
    @item_repository.find_by_id(id)
  end

  def analyst
    SalesAnalyst.new(self)
  end

  def invoices
    @invoice_repository
  end

  def find_invoice_by_id(id)
    @invoice_repository.find_by_id(id)
  end

  def transactions
    @transaction_repository
  end

  def customers
    @customer_repository
  end

  def invoice_items
    @invoice_item_repository
  end

  def find_customer_by_id(id)
    @customer_repository.find_by_id(id)
  end

end
