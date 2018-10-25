class Merchant
  attr_reader :id
  attr_accessor :name

  def initialize(merchant_data)
    @id = merchant_data[:id].to_i
    @name = merchant_data[:name]
  end

end
