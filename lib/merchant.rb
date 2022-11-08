class Merchant
  attr_reader :id, :name

  def initialize(args)
    @id = args[:id].to_i
    @name = args[:name]
    @created_at = args[:created_at]
  end

  def update(attributes)
    @name = attributes[:name]
  end
end
