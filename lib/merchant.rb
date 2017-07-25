class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(id, name, created_at, updated_at)
    @id = id
    @name = name
    @created_at = created_at
    @updated_at = updated_at
  end

  def items
    self.id 
  end

end