class Merchant
  attr_reader :id 
  def initialize(merchant_info)
    @id = merchant_info[:id]
  end
end
