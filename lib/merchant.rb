class Merchant
  attr_reader :id, :name

  def initialize(merchant_info = {})
    @id = merchant_info.fetch(:id)
    @name = merchant_info.fetch(:name)
  end

end


merch = Merchant.new({:id => 1234, :name => 'Lucy'})
puts merch.id
puts merch.name
