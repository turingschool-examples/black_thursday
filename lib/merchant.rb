class Merchant
  attr_accessor :name
  attr_reader :id
  def initialize(merchant_info)
    @id = merchant_info[:id]
    @name = merchant_info[:name]
  end
end
