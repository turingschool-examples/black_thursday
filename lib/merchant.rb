class Merchant
  attr_reader :merchant
  def initialize(merchant)
    @merchant = merchant
  end
  
  def id
    merchant.fetch(:id).to_i
  end

  def name
    merchant.fetch(:name)
  end
end
