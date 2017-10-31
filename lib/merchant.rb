class Merchant

  attr_reader :name, :parent, :id

  def initialize(data, parent)
    @name = data[:name]
    @id = data[:id]
    @parent = parent
  end

end
