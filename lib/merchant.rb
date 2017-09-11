#Lauren doing this one!

=begin
Merchant

The merchant is one of the critical concepts in our data hierarchy.

id - returns the integer id of the merchant
name - returns the name of the merchant
We create an instance like this:

m = Merchant.new({:id => 5, :name => "Turing School"})
=end

class Merchant

  attr_reader :id, :name

  def initialize(hash)
    @merchant_hash = hash
    @id = hash[:id]
    @name = hash[:name]
  end


  def id
    @id.to_i
  end

end
