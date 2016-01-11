class Merchant
  attr_reader :name, :merchant_id, :updated_at, :created_at

  def initialize (merchant)
    @name = merchant[:name]
    @created_at = (merchant[:created_at])
    @updated_at = (merchant[:updated_at])
    @merchant_id = merchant[:merchant_id]
  end

end
