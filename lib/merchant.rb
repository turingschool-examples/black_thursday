class Merchant
  attr_accessor :name,
                  :id

  def initialize(merchant_info)
    @id = merchant_info[:id].to_i
    @name = merchant_info[:name]
  end
end
