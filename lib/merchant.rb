class Merchant
  attr_reader :id,
              :name

  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    @created_at = hash[:created_at]
    @updated_at = hash[:updated_at]
  end
end
