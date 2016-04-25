require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require 'bigdecimal'
require 'csv'

class SalesEngine

  attr_reader :files
  attr_accessor :merchant_repo, :item_repo, :invoice_repo, :invoice_item_repo,
                :customer_repository, :transaction_repo

  def initialize(files)
    @files = files
    @merchant_repo = nil
    @item_repo = nil
    @invoice_repo = nil
    @invoice_item_repo = nil
    @transaction_repo = nil
    @cusomter_repo = nil
  end

  def self.from_csv(files)
    SalesEngine.new(files)
  end

  def merchants
    if @merchant_repo.nil?
      @merchant_repo = MerchantRepository.new(files[:merchants], self)
      @merchant_repo.load_csv_data
    end
    @merchant_repo
  end

  def items
    if @item_repo.nil?
      @item_repo = ItemRepository.new(files[:items], self)
      @item_repo.load_csv_data
    end
    @item_repo
  end

  def invoices
    if @invoice_repo.nil?
      @invoice_repo = InvoiceRepository.new(files[:invoices], self)
      @invoice_repo.load_csv_data
    end
    @invoice_repo
  end

  def invoice_items
    if @invoice_item_repo.nil?
      @invoice_item_repo = InvoiceItemRepository.new(files[:invoice_items], self)
      @invoice_item_repo.load_csv_data
    end
    @invoice_item_repo
  end

  def transactions
    if @transaction_repo.nil?
      @transaction_repo = TransactionRepository.new(files[:transactions], self)
      @transaction_repo.load_csv_data
    end
    @transaction_repo
  end


end
