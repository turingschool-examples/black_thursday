
class Merchant
  attr_reader :id,
              :name,
              :parent

  def initialize(row, parent)
    @id   = row[:id]
    @name = row[:name]
    @parent = parent
  end

  def items
    puts parent.parent.items.find_all_by_merchant_id(self.id)
  end

end
