require_relative 'merchant_repo'
require_relative 'item_repo'
require 'csv'
require 'pry'

class SalesEngine

  attr_reader   :files, :items, :merchants
  attr_accessor :merchant_repo, 
                :item_repo
  
               

  def initialize(files)
    @file              = files
    @merchant_repo     = MerchantRepo.new(files[:merchants])
    @item_repo         = ItemRepo.new(files[:items])
   
  end

  def self.from_csv(files)
    self.new(files)
  end

  # def total_merchants
  #   merchants.all.length
  # end

  # def total_invoices
  #   invoices.all.length
  # end

end

