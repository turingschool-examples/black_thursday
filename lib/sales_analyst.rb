require 'csv'
require 'bigdecimal/util'
require_relative 'sales_engine'
require_relative 'item'
require_relative 'merchant'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice'
require_relative 'invoice_repository'

class SalesAnalyst
  attr_reader :items,
              :merchants
  def initialize(item_repo, merchant_repo)
    @items = item_repo
    @merchants = merchant_repo
    # @invoices = invoice_repo
  end

  def item_count
    items.all.count
  end

  def items_per_merchant(id)
    items.find_all_by_merchant_id(id).count
  end

  def merchant_count
    merchants.all.count
  end

  def average_items_per_merchant
    (item_count / merchant_count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchants = @merchants.all.map do |merchant|
      @items.find_all_by_merchant_id(merchant.id).count
    end
    average = average_items_per_merchant
    differences = 0
    merchants.map do |num|
      differences += (num - average)**2
    end
    Math.sqrt(differences / (merchants.count - 1).to_f).round(2)
  end
  #
  # def merchants_with_high_item_count
  #
  # end
  #
  def average_item_price_for_merchant(id)
    stock = (items.find_all_by_merchant_id(id))
    price_array = stock.map { |stock| stock.unit_price }.sum
    
    (price_array / stock.count).round(2)
  end
  
  def average_average_price_per_merchant
    
  end
  
  # def golden_items
  # 
  # end

end
