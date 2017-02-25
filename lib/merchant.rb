class Merchant
  attr_reader :id, :name, :parent

  def initialize(row, parent)
    @id = row[:id].to_i
    @name = row[:name]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
    @parent = parent
  end

  def items
    # Merchant Repo can find Merchant by id
    # how can merchant talk to item repo methods from here?
    # should return array of item objects that only belong to specific merchant
    parent.engine.items.find_all_by_merchant_id(self.id)
    # parent = MerchantRepository
    # parent.engine = SalesEngine
    # parent.engine.items = ItemRepository
    # parent.engine.items.find_all_by_merchant_id = collection of items
    # binding.pry
  end
end
