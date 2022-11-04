# frozen_string_literal: true

# This is the Merchant Class
class Merchant
  attr_reader :id,
              :name

  def initialize(data, repo)
    @id   = (data[:id]).to_i
    @name = data[:name]
    @merchant_repo = repo
  end

  def update(name)
    @name = name[:name]
  end

  # Fetches items owned by merchant
  def _items
    @_items ||= @merchant_repo.engine.items.find_all_by_merchant_id(@id)
  end

  # Returns number of items owned by merchant.
  def item_count
    _items.count
  end
end
