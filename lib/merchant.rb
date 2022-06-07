class Merchant
  attr_reader :id, :name, :created_at, :updated_at

  def initialize(data)
    @id = data[:id].to_i
    @name = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def update(attributes)
    @name = attributes[:name] unless attributes[:name].nil?
    @updated_at = Time.now
  end
end
