# frozen_string_literal: true

# Sales Engine class for managing data
class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(items_and_merchants = nil)
    @items = items_and_merchants[:items]
    @merchants = items_and_merchants[:merchants]
  end

  def self.from_csv(items_and_merchants)
    items_repo = ItemRepository.new()
    new(items_and_merchants)
  end
end
