class Merchant
  attr_reader :merchant_id, :merchant_name, :merchant_created_at, :merchant_updated_at

  def initialize(merchant, merch_repo_parent = nil)
    @merchant_id = merchant[:merchant_id].to_i
    @merchant_name = merchant[:merchant_name]
    @merchant_created_at = merchant[:merchant_created_at]
    @merchant_updated_at = merchant[:merchant_updated_at]
    @parent = merch_repo_parent
  end

  def find_id
    @merchant_id
  end

  def find_name
    @merchant_name
  end

  def when_created_at
    if @merchant_created_at.class == String
     Time.parse(merchant_created_at)
    elsif merchant_created_at.class == Time
     merchant_created_at
    end
  end

  def when_updated_at
    if @merchant_updated_at.class == String
      Time.parse(merchant_updated_at)
    elsif merchant_updated_at.class == Time
      merchant_updated_at
    end
  end

end
