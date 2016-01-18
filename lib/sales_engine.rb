require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require_relative 'load_data'
require          'csv'

class SalesEngine
  attr_reader :repo_rows
  attr_accessor :items, :merchants, :invoices, :invoice_items, :transactions, :customers

  def initialize(repo_rows)
    start_up_engine(repo_rows)
  end


  def self.from_csv(csv_hash)
    repo_rows = csv_hash.map do |type, filename|
      [type, LoadData.load_data(filename)]
    end.to_h
    SalesEngine.new(repo_rows)
  end

  def start_up_engine(repo_rows)
    load_merchants_repo(repo_rows) if repo_rows[:merchants]
    load_items_repo(repo_rows) if repo_rows[:items]
    load_invoice_repo(repo_rows) if repo_rows[:invoices]
    load_invoice_item_repo(repo_rows) if repo_rows[:invoice_items]
    load_transaction_repo(repo_rows) if repo_rows[:transactions]
    load_customer_repo(repo_rows) if repo_rows[:customers]
  end

  def load_merchants_repo(repo_rows)
    @merchants  = MerchantRepository.new(repo_rows[:merchants])
  end

  def load_items_repo(repo_rows)
    @items      = ItemRepository.new(repo_rows[:items])
    if repo_rows[:items]
      items_to_merchants
      merchants_to_items
    end
  end

  def load_invoice_repo(repo_rows)
    @invoices   = InvoiceRepository.new(repo_rows[:invoices])
    if repo_rows[:merchants]
      invoices_to_merchants
      merchants_to_invoices
    end
  end

#ITERATION 3 STUFF=================================================
  def load_invoice_item_repo(repo_rows)
    @invoice_items = InvoiceItemRepository.new(repo_rows[:invoice_items])
    if repo_rows[:invoice_items]
      #most likely where the relationship will be added !
    end
  end
    #double check if the way I used BigDecimal for credit card number
    #in the TransactionRepository/Transaction class is correct
  def load_transaction_repo(repo_rows)
    @transactions = TransactionRepository.new(repo_rows[:transactions])
    if repo_rows[:transactions]
      #most likely where the relationship will be added !
    end
  end

  def load_customer_repo(repo_rows)
    @customers = CustomerRepository.new(repo_rows[:customers])
    if repo_rows[:customers]
      #most likely where the relationship will be added !
    end
  end

#=====================================================================
  def items_to_merchants
    @merchants.all.map { |merchant|
      merchant.items = @items.find_all_by_merchant_id(merchant.id)}
  end

  def merchants_to_items
    @items.all.map { |item|
      item.merchant = @merchants.find_by_id(item.merchant_id)}
  end

  def invoices_to_merchants
    @merchants.all.map { |merchant|
      merchant.invoices = @invoices.find_all_by_merchant_id(merchant.id)}
  end

  def merchants_to_invoices
    @invoices.all.map { |invoice|
      invoice.merchant = @merchants.find_by_id(invoice.merchant_id)}
  end
end
