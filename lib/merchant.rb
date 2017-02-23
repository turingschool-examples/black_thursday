class Merchant

  attr_reader :name, :id

  def initialize(name, id)
    @name = name
    @id = id.to_i
  end
end