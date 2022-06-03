require 'bigdecimal'
require 'pry'
require './lib/item_repository'
class SalesAnalyst
  attr_reader :item_repository,
              :merchant_repository,
              :invoice_repository

  def initialize(item_repository, merchant_repository, invoice_repository)
    @item_repository = item_repository
    @merchant_repository = merchant_repository
    @invoice_repository = invoice_repository
  end

  def average_items_per_merchant
   ((@item_repository.all.count).to_f / (@merchant_repository.all.count).to_f).round(2)
  end

end
