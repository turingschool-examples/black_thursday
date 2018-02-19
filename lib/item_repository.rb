require 'CSV'
require_relative '../lib/item'
require 'pry'
class ItemRepository
  def initialize(filepath)
    @items = []
    find_items(filepath)
  end

  def all
    @items
  end

  def find_items(filepath)
    item_repo = CSV.read(filepath, headers: true)
    id          = item_repo['id']
    name        = item_repo['name']
    description = item_repo['description']
    unit_price  = item_repo['unit_price']
    merchant_id = item_repo['merchant_id']
    created_at  = item_repo['created_at']
    updated_at  = item_repo['updated_at']
    
    [id, name, description, unit_price, merchant_id,
     created_at, updated_at].transpose
  end
end
