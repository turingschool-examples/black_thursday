require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'csv_parser'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

class SalesEngine
  attr_reader  :items,
               :merchants,
               :invoices,
               :invoice_items,
               :transactions,
               :customers

  def initialize(data)
    @items ||= ItemRepository.new(data[:items])
    @merchants ||= MerchantRepository.new(data[:merchants])
    @invoices ||= InvoiceRepository.new(data[:invoices])
    @invoice_items ||= InvoiceItemRepository.new(data[:invoice_items])
    @transactions ||= TransactionRepository.new(data[:transactions])
    @customers ||= CustomerRepository.new(data[:customers])
    set_all_relationships
  end

  def self.from_csv(csv_content)
    data = CsvParser.new.collect_data(csv_content)
    SalesEngine.new(data)
  end

  def set_all_relationships
    set_merchant_items
    set_item_merchant
    set_merchant_for_invoice
    set_invoice_for_merchant
    set_items_for_invoice_items
    set_invoice_items_for_invoice
    set_items_for_invoice
    set_transactions_for_invoice
    set_customer_for_invoice
    set_invoice_for_transaction
    set_customer_for_merchant
  end

  def items_by_merchant_id(merchant_id)
    items.find_all_by_merchant_id(merchant_id).uniq
  end

  def set_merchant_items
    merchants.all.each do |merchant|
      merchant.items = items_by_merchant_id(merchant.id)
    end
  end

  def merchant_by_item_id(item)
    merchants.find_by_id(item.merchant_id)
  end

  def set_item_merchant
    items.all.each do |item|
       item.merchant = merchant_by_item_id(item)
    end
  end

  def invoice_by_merchant_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def set_merchant_for_invoice
    invoices.all.each do |invoice|
      invoice.merchant = invoice_by_merchant_id(invoice.merchant_id)
    end
  end

  def merchant_of_invoice(merchant_id)
     invoices.find_all_by_merchant_id(merchant_id)
  end

  def set_invoice_for_merchant
    merchants.all.each do |merchant|
      merchant.invoices = merchant_of_invoice(merchant.id)
    end
  end

  def set_items_for_invoice_items
    invoice_items.all.each do |invoice_item|
      invoice_item.item = items.find_by_id(invoice_item.item_id)
    end
  end

  def set_invoice_items_for_invoice
    invoices.all.each do |invoice|
      invoice.invoice_items = invoice_items.find_all_by_invoice_id(invoice.id).uniq
    end
  end

  def set_items_for_invoice
    invoices.all.each do |invoice|
       invoice.items = invoice.invoice_items.map do |invoice_item|
         invoice_item.item
       end
     end
  end

  def invoice_for_transaction(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id)
  end

  def set_transactions_for_invoice
    invoices.all.each do |invoice|
      invoice.transactions = invoice_for_transaction(invoice.id)
    end
  end

  def set_invoice_for_transaction
    invoices.all.each do |invoice|
      invoice.transactions.each do |transaction|
        transaction.invoice = invoice
      end
    end
  end

  def invoice_by_customer_id(customer_id)
    customers.find_by_id(customer_id)
  end

  def set_customer_for_invoice
    invoices.all.each do |invoice|
      invoice.customer = invoice_by_customer_id(invoice.customer_id)
    end
  end

  def invoices_for_merchant(merchant_id)
  end

  def find_customer_by_merchant_id(merchant_id)
    returned_invoices = invoices.find_all_by_merchant_id(merchant_id).uniq
    returned_customer_id = returned_invoices.map do |invoice|
      invoice.customer_id
    end
    returned_customer_id.map do |customer_id|
      customers.find_by_id(customer_id)
    end.uniq
  end

  def set_customer_for_merchant
    merchants.all.map do |merchant|
      merchant.customers = find_customer_by_merchant_id(merchant.id)
    end
  end

end
