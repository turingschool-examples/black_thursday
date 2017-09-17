require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'customer_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'

class SalesEngine

  attr_accessor :merchant_csv_filepath,
                :item_csv_filepath,
                :invoice_csv_filepath,
                :customer_csv_filepath,
                :invoice_item_csv_filepath,
                :transaction_csv_filepath

  def self.from_csv(info)
    se = SalesEngine.new
    se.merchant_csv_filepath = info[:merchants]
    se.item_csv_filepath = info[:items]
    se.invoice_csv_filepath = info[:invoices]
    se.customer_csv_filepath = info[:customers]
    se.invoice_item_csv_filepath = info[:invoice_items]
    se.transaction_csv_filepath = info[:transactions]
    se
  end

  def initialize
    @merchant_csv_filepath = ''
    @item_csv_filepath = ''
    @invoice_csv_filepath = ''
    @customer_csv_filepath = ''
    @invoice_item_csv_filepath = ''
    @transaction_csv_filepath = ''
  end

  def merchants
    if @merchant_repository.nil?
      @merchant_repository = MerchantRepository.new(@merchant_csv_filepath, self)
    else
      @merchant_repository
    end
  end

  def items
    if @item_repository.nil?
      @item_repository = ItemRepository.new(@item_csv_filepath, self)
    else
      @item_repository
    end
  end

  def invoices
    if @invoice_repository.nil?
      @invoice_repository = InvoiceRepository.new(@invoice_csv_filepath, self)
    else
      @invoice_repository
    end
  end

  def customers
    if @customer_repository.nil?
      @customer_repository = CustomerRepository.new(@customer_csv_filepath, self)
    else
      @customer_repository
    end
  end

  def invoice_items 
    if @invoice_items.nil?
      @invoice_items = InvoiceItemRepository.new(@invoice_item_csv_filepath, self)
    else
      @invoice_items
    end
  end

  def transactions
    if @transactions.nil?
      @transactions = TransactionRepository.new(@transaction_csv_filepath, self)
    else
      @transactions
    end
  end

  def total_merchants
    self.merchants.merchants.length
  end

  def total_items
    self.items.items.length
  end

  def average_items_per_merchant
    total_items / total_merchants.to_f
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
