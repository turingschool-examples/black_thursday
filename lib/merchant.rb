class Merchant
  attr_accessor :name
  attr_reader   :id

  def initialize(merchant_details)
    @id = merchant_details[:id].to_i
    @name = merchant_details[:name]
  end
end
