class Merchant
  attr_reader :id
  attr_accessor :name

  def initialize(merchant_info)
    @id = merchant_info[:id]
    @name = merchant_info[:name]
  end
end
