# frozen_string_literal: true

require 'bigdecimal'

require_relative 'item_repository'
require_relative 'merchant_repository'

# Defines sales engine
class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def self.from_csv(files)
    items = ItemRepository.new files[:items]
    merchants = MerchantRepository.new files[:merchants]
    new items, merchants
  end
end
