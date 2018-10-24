class Merchant
  attr_reader :id, :name

  def initialize(merchant_data)
    @id = merchant_data[:id].to_i
    @name = merchant_data[:name].upcase
  end

end
