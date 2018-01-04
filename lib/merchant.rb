class Merchant
  attr_reader   :id,
                :name,
                :created_at,
                :updated_at

  attr_accessor :item_count

  def initialize(info, merchant_repository = "")
    @id = info[:id]
    @name = info[:name]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
    @item_count = 0
    parent_generator(merchant_repository)
  end

  def items(parent)
    parent_generator(parent).items.items.values
  end

  def parent_generator(parent)
    parent
  end

  def downcaser
    @name.downcase
  end

end
