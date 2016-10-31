require_relative 'repository_functions'
require_relative 'item'


class ItemRepository

  include RepositoryFunctions






  def all
    items
  end

  def find_by_id(id)
    RepositoryFunctions.find_by(items, id)
  end

  def find_by_name(name)
    RepositoryFunctions.find_by(items, name)
  end

  def find_all_with_description(description)
    RepositoryFunctions.find_all(items, description)
  end

  def find_all_by_price(price)
    RepositoryFunctions.find_all(items, price)
  end

  def find_all_by_price_range(price_range)
    prices.find_all {|price| price_range.include?(price)}
  end

  def find_all_by_merchant_id(merchant_id)
    RepositoryFunctions.find_all(items, merchant_id)
  end
