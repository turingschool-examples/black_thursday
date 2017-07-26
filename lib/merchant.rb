class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :mr

  def initialize(id, name, created_at, updated_at, mr)
    @id = id
    @name = name
    @created_at = created_at
    @updated_at = updated_at
    @mr = mr
  end

  def items
    mr.fetch_merchant_id(self.id)
  end

end