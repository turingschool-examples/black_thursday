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
    @merchant_repo     = MerchantRepo.new(files[:merchants], self)
    @item_repo         = ItemRepo.new(files[:items], self)
   
  end

  def self.from_csv(files)
    self.new(files)
  end

  def total_merchants
    @merchant_repo.all.length
  end

  def find_all_by_merchant_id(id)
    @item_repo.find_all_by_merchant_id(id)
  end

  # def total_invoices
  #   invoices.all.length
  # end

end

