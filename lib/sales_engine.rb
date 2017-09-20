require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'customer_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'

class SalesEngine

  attr_accessor :merchant_csv_file,
                :item_csv_file,
                :invoice_csv_file,
                :customer_csv_file,
                :invoice_item_csv_file,
                :transaction_csv_file

  def self.from_csv(info)
    se = SalesEngine.new
    se.merchant_csv_file = info[:merchants]
    se.item_csv_file = info[:items]
    se.invoice_csv_file = info[:invoices]
    se.customer_csv_file = info[:customers]
    se.invoice_item_csv_file = info[:invoice_items]
    se.transaction_csv_file = info[:transactions]
    se
  end

  def initialize
    @merchant_csv_file = ''
    @item_csv_file = ''
    @invoice_csv_file = ''
    @customer_csv_file = ''
    @invoice_item_csv_file = ''
    @transaction_csv_file = ''
  end

  def merchants
      @merchant_repository ||= MerchantRepository.new(@merchant_csv_file, self)
  end

  def items
      @item_repository ||= ItemRepository.new(@item_csv_file, self)
  end

  def invoices
      @invoice_repository ||= InvoiceRepository.new(@invoice_csv_file, self)
  end

  def customers
      @customer_repository ||= CustomerRepository.new(@customer_csv_file, self)
  end

  def invoice_items
      @invoice_items ||= InvoiceItemRepository.new(@invoice_item_csv_file, self)
  end

  def transactions
      @transactions ||= TransactionRepository.new(@transaction_csv_file, self)
  end

  def total_merchants
    self.merchants.merchants.length
  end

  def total_items
    self.items.items.length
  end

  def merchant_item_count
    self.merchants.merchants.map do |merchant|
      merchant.items.count
    end
  end

  def total_invoices
    self.invoices.invoices.length
  end

  def merchant_invoice_count
    self.merchants.merchants.map {|merchant| merchant.invoices.count}
  end



end
