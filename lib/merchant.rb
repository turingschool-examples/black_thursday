require './lib/item_repo'
class Merchant
  attr_reader :id,
              :name,
              :repo

  def initialize(merchant_details, merchant_repo = nil)
    @id   = merchant_details[:id].to_i
    @name = merchant_details[:name]
    @parent = merchant_repo
  end

  def items
    @parent.find_all_items_by_merchant_id(self.id)
  end
end
