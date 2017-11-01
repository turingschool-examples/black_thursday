class Merchant
  attr_reader :name,
              :repository,
              :id,
              :items

  def initialize(data, parent)
    @name = data[:name]
    @id = data[:id]
    @repository = parent
  end

  def items

  end

end
