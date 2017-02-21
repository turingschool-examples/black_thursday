class Merchant
  attr_reader :merchant_hash

  def initialize(hash)
    @merchant_hash = hash
  end

  def id
    merchant_hash[:id]
  end

  def name
    merchant_hash[:name]
  end

end

m = Merchant.new({:id => 5, :name => "Turing School"})
