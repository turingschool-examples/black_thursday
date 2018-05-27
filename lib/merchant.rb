class Merchant
  attr_reader :id,
              :name

  def initialize(attributes)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
  end

  def update_name(attributes)
    @name = attributes[:name]
  end
end
