class Merchant
  attr_accessor :id,
                :name,
                :created_at,
                :updated_at

  def initialize(hash)
    @id   = hash[:id]
    @name = hash[:name]
    @created_at = hash[:created_at]
    @updated_at = hash[:updated_at]
  end
end
