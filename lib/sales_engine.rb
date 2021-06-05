require 'spec_helper'

class SalesEngine
  attr_reader :item_repo,
              :merchant_repo

  def initialize(library)
    @item_repo = ItemRepository.new(library[:items])
    @merchant_repo = MerchantRepository.new(library[:merchants])
  end
end
