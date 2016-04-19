class Merchant
  attr_reader :id, :name  # => nil

  def initialize(merchant_hash = {})
    @id = merchant_hash.fetch(:id)
    @name = merchant_hash.fetch(:name)
  end                                   # => :initialize

end  # => :initialize


# merch = Merchant.new({:id => 1234, :name => 'Lucy'})
# puts merch.id
# puts merch.name
