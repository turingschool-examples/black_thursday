class Merchant
  attr_reader :id,
              :name,
              :created_at
  attr_accessor :updated_at

  def initialize(attributes)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @created_at = Time.parse(attributes[:created_at].to_s)
    @updated_at = Time.parse(attributes[:updated_at].to_s)
  end

  def update_name(attributes)
    @name = attributes[:name]
  end

  def update_updated_at(attributes)
    @updated_at = attributes
  end
end
