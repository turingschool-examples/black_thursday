class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at
  def initialize(hash)
    @id         = hash[:id].to_i
    @name       = hash[:name]
    @created_at = hash[:created_at]
    @updated_at = hash[:updated_at]
  end
end
