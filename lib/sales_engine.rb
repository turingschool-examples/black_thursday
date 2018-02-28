require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

class SalesEngine
  attr_reader :items, :merchants, :invoices, :invoice_items,
              :transactions, :customers

  def self.from_csv(hash)
    SalesEngine.new(hash)
  end

  def initialize(hash)
    @items = ItemRepository.new(hash[:items], self)
    @merchants = MerchantRepository.new(hash[:merchants], self)
    @invoices = InvoiceRepository.new(hash[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(hash[:invoice_items], self)
    @transactions = TransactionRepository.new(hash[:transactions], self)
    @customers = CustomerRepository.new(hash[:customers], self)
  end

  def item_repo_finds_all_by_merchant_id(id)
    @items.find_all_by_merchant_id(id)
  end

  def merch_repo_find_all_by_id(id)
    @merchants.find_by_id(id)
  end

  def engine_finds_invoices_via_invoice_repo(id)
    @invoices.find_all_by_merchant_id(id)
  end

  def engine_finds_invoice_via_invoice_id(id)
    @invoices.find_by_id(id)
  end

  def engine_finds_merchant_via_merchant_repo(id)
    @merchants.find_by_id(id)
  end

  def engine_finds_items_via_invoice_items_repo(id)
    invoice_items = @invoice_items.find_all_by_invoice_id(id)
    invoice_items.map do |invoice_item|
      @items.find_by_id(invoice_item.item_id)
    end
  end

  def engine_finds_customer_via_customer_repo(id)
    @customers.find_by_id(id)
  end

  def engine_finds_transactions_via_invoice_id(id)
    @transactions.find_all_by_invoice_id(id)
  end

  def engine_finds_merchant_customers_via_invoice_repo(id)
    merchant_invoices = engine_finds_invoices_via_invoice_repo(id)
    merchant_invoices.map do |invoice|
      @customers.find_by_id(invoice.customer_id)
    end.uniq.compact
  end

  def engine_finds_customer_merchants_via_invoice_repo(id)
    customer_invoices = @invoices.find_all_by_customer_id(id)
    customer_invoices.map do |invoice|
      @merchants.find_by_id(invoice.merchant_id)
    end.uniq.compact
  end

  def engine_finds_invoice_transactions_and_evaluates(id)
    transactions = @transactions.find_all_by_invoice_id(id)

    transactions.any? do |transaction|
      transaction.result.downcase == "success"
    end
  end

  def invoice_items_from_invoice(id)
    @invoice_items.find_all_by_invoice_id(id)
  end

  def engine_finds_paid_invoice_and_evaluates_cost(id)
    if engine_finds_invoice_transactions_and_evaluates(id)
      invoice_items = @invoice_items.find_all_by_invoice_id(id)

      invoice_items.reduce(0) do |sum, invoice_item|
        cost = invoice_item.unit_price_to_dollars * invoice_item.quantity.to_i
        sum += cost
        BigDecimal.new(sum, 5)
      end
    end
  end
end
