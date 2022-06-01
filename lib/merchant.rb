class Merchant

  attr_reader :id, :name
  def initialize(data)
    @id = data[:id]
    @name = data[:name]
  end

  def update_info(attributes)
    attributes.each do |key, value|
      @name = value if key == :name
    end
  end
end
