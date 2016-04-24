class Merchant
  attr_reader :id, :name
  attr_accessor :items, :invoices

  def initialize(name_id)
    @id = name_id[:id].to_i
    @name = name_id[:name]
  end

  def inspect
    "#<#{self.class}"
  end
  
end
