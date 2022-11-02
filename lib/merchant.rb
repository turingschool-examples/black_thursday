class Merchant
  attr_accessor :name
  attr_reader   :id

  def initialize(merchant_details)
    @id = merchant_details[:id]
    @name = merchant_details[:name]
  end
end
