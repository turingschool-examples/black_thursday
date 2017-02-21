
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


# The merchant is one of the critical concepts in our data hierarchy.
#

# id - returns the integer id of the merchant

# name - returns the name of the merchant

# We create an instance like this:
#
# m = Merchant.new({:id => 5, :name => "Turing School"})
