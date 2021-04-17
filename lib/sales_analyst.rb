require_relative './sales_engine'
require_relative './items'
require_relative './merchants'
require_relative './items_repo'
require_relative './merchants_repo'
require 'csv'

class SalesAnalyst
  attr_reader :items_repo,
              :merchants_repo

  def initialize(items_repo, merchants_repo)
    @items_repo     = items_repo
    @merchants_repo = merchants_repo
  end

  def all_items
    @items_repo.all
  end

  def all_merchants
    @merchants_repo.all
  end

  def average_items_per_merchant
    total = (all_items.count / all_merchants.count.to_f).round(2)
  end
  # require'pry';binding.pry
end
