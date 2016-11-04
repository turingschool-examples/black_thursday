require_relative 'merchant_repo'
require_relative 'item_repo'
require 'csv'
require 'pry'

class SalesEngine

  attr_reader   :files, :items, :merchants
  attr_accessor :merchant_repo, 
                :item_repo,
                :invoice_repo
  

  def self.from_csv(files)
    @merchant_repo     = MerchantRepo.new(files[:merchants], self)
    @item_repo         = ItemRepo.new(files[:items], self)
    @invoice_repo      = InvoiceRepo.new(files[:invoices], self)
    self
  end

  def self.merchants
    @merchant_repo
  end

  def self.items
    @item_repo
  end

  def self.invoices
    @invoice_repo
  end

  def self.total_merchants
    @merchant_repo.all.length
  end

  def self.find_all_by_merchant_id(id)
    @item_repo.find_all_by_merchant_id(id)
  end

  def self.find_all_invoices_by_id(id)
    @invoice_repo.find_all_by_merchant_id(id)
  end

  def total_invoices
    @invoice_repo.all.length
  end

end

