class Merchant
  attr_reader   :id, :name, :created_at
  attr_accessor :items, :invoices, :customers

  def initialize(name_id)
    @id = name_id[:id].to_i
    @name = name_id[:name]
    @created_at = Time.parse(name_id[:created_at])
  end

  def inspect
    "#<#{self.class}"
  end

end
