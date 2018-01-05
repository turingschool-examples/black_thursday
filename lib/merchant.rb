class Merchant
  attr_reader   :id,
                :name,
                :created_at,
                :updated_at

  attr_accessor :item_count

  def initialize(info, merchant_repository = "")
    @id = info[:id].to_i
    @name = info[:name]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
    @item_count = 0
    @parent = merchant_repository

  end

  def items
    @parent.items_by_id(@id.to_i)
  end

  def downcaser
    @name.downcase
  end

  def items
    @parent.items
  end

  def downcaser
    @name.downcase
  end

end
