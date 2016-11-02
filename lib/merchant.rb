class Merchant
  attr_reader :id,
              :name,
              :parent

  def initialize(merchant_info = nil, repo = nil)
    return if merchant_info.to_h.empty?
    @parent = repo
    @id     = merchant_info.to_h[:id].to_i
    @name   = merchant_info.to_h[:name].to_s
  end

  def items
    parent.find_items_by_merchant_id(id)
  end

end