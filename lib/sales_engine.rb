require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'merchant'
require_relative 'item'
require_relative 'csv_parser'
require_relative 'invoice_repository'
require_relative 'invoice'
require_relative 'invoice_item_repository'
require_relative 'invoice_item'

class SalesEngine
  attr_reader  :merchants_data, :items_data, :invoices_data, :invoice_item_data, :transactions_data, :customers_data

  def initialize(items_data, merchants_data, invoices_data, invoice_item_data, transactions_data, customers_data)
    @items_data = items_data
    @merchants_data = merchants_data
    @invoices_data = invoices_data
    @invoice_item_data = invoice_item_data
    @transactions_data = transactions_data
    @customers_data = customers_data
    set_merchant_items
    set_item_merchant
    set_merchant_for_invoice
    set_invoice_for_merchant
  end

  def self.from_csv(csv_content)
    items_csv = csv_content[:items]
    merchants_csv = csv_content[:merchants]
    invoices_csv = csv_content[:invoices]
    invoice_item_csv = csv_content[:invoice_items]
    transactions_csv = csv_content[:transactions]
    customers_csv = csv_content[:customers]
    items_data = CsvParser.new.items(items_csv)
    merchants_data = CsvParser.new.merchants(merchants_csv)
    invoices_data = CsvParser.new.invoices(invoices_csv)
    invoice_item_data = CsvParser.new.invoice_items(invoice_item_csv)
    transactions_data = CsvParser.new.transactions(transactions_csv)
    customers_data = CsvParser.new.customers(customers_csv)
    SalesEngine.new(items_data, merchants_data, invoices_data, invoice_item_data, transactions_data, customers_data)
  end

  def items
    @items ||= ItemRepository.new(items_data)
  end

  def merchants
    @merchants ||= MerchantRepository.new(merchants_data)
  end

  def invoices
    @invoices ||= InvoiceRepository.new(invoices_data)
  end

  def invoice_items
    @invoice_items ||= InvoiceItemRepository.new(invoice_item_data)
  end

  def transactions
    @transactions ||= TransactionRepository.new(transactions_data)
  end

  def customers
    @customers ||=
    CustomerRepository.new(customers_data)
  end

  def items_by_merchant_id(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
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

end
