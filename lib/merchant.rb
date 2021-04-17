class Merchant
  attr_accessor :id,
                :name

  def initialize(merchant_info, engine)
    @id = merchant_info[:id].to_i
    @name = merchant_info[:name]
  end
end
