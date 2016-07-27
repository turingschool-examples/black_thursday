require './lib/item_repo'
class Merchant
  attr_reader :id,
              :name,
              :repo

  def initialize(merchant_details, repo = nil)
    @id   = merchant_details[:id].to_i
    @name = merchant_details[:name]
    @repo = repo
  end

  def items
    # @repo.sales_engine.item_repo.find_all_by_merchant_id(self.id)
    # @repo.find_all_items_by_merchant_id(self.id)
    ItemRepo.data.find_all_by_merchant_id(self.id)
  end
end
