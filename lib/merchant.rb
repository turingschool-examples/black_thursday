class Merchant
  attr_reader :id, :name
  
  def initialize(data)
    @id  = data[:id]
    @name = data[:name]
  end
end

#m = Merchant.new({:id => 5, :name => "Turing School"})