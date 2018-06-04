class Merchant
  attr_reader :id,
              :name,
              :created_at
  attr_accessor :updated_at

  def initialize(attributes)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @created_at = Time.parse(attributes[:created_at])
    @updated_at = Time.parse(attributes[:updated_at])
  end

  def update_name(attributes)
    @name = attributes[:name]
  end
end
