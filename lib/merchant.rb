class Merchant
attr_reader :id, :name, :merchant_created_at, :merchant_updated_at

  def initialize(merchant, merch_repo_parent = nil)
    @id = merchant[:id].to_i
    @name = merchant[:name]
    @merchant_created_at = merchant[:created_at]
    @merchant_updated_at = merchant[:updated_at]
    @parent = merch_repo_parent
  end

  def created_at
    if merchant_created_at.class == String
     Time.parse(merchant_created_at)
   elsif merchant_created_at.class == Time
     merchant_created_at
    end
  end

  def updated_at
    if merchant_updated_at.class == String
      Time.parse(merchant_updated_at)
    elsif merchant_updated_at.class == Time
      merchant_updated_at
    end
  end

  def items
    @parent.se_parent.items.find_all_by_merchant_id(@id)
  end

end
