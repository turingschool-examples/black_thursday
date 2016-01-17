require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'load_data'
require          'csv'

class SalesEngine
  attr_reader :repo_rows
  attr_accessor :items, :merchants, :invoices

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
<<<<<<< HEAD
    @items                = ItemRepository.new(repo_rows[:items])
    @merchants            = MerchantRepository.new(repo_rows[:merchants])
    @invoices             = InvoiceRepository.new(repo_rows[:invoices])
    items_to_merchants
    merchants_to_items
    load_merchants_repo(repo_rows) if repo_rows[:merchants]
    load_items_repo(repo_rows) if repo_rows[:items]
    load_invoice_repo(repo_rows) if repo_rows[:invoices]
  end

  def load_merchants_repo(repo_rows)
    @merchants  = MerchantRepository.new(repo_rows[:merchants])
  end

  def load_items_repo(repo_rows)
=======
>>>>>>> parent of c690b71... linked between accounts made
    @items      = ItemRepository.new(repo_rows[:items])
    @merchants  = MerchantRepository.new(repo_rows[:merchants])
    @invoices   = InvoiceRepository.new(repo_rows[:invoices])
<<<<<<< HEAD
    if repo_rows[:merchants]
      invoices_to_merchants
      merchants_to_invoices
      binding.pry
    end
=======
    items_to_merchants
    merchants_to_items
    invoices_to_merchants
    merchants_to_invoices
>>>>>>> parent of c690b71... linked between accounts made
  end


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
    @items.all.map { |invoice|
      invoice.merchant = @merchants.find_by_id(invoice.merchant_id)}
  end
end
