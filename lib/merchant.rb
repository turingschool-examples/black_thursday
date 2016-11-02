class Merchant

  attr_reader   :id,
                :name,
                :parent,
                :created_at,
                :updated_at

  def initialize(merchant_hash, parent=nil)
    @id = merchant_hash[:id]
    @name = merchant_hash[:name]
    @parent = parent
    @created_at = merchant_hash[:created_at]
    @updated_at = merchant_hash[:updated_at]
  end

  def items
    parent.find_items_by_merchant_id(id)
  end

end
