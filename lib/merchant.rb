class Merchant

  attr_reader    :id
  attr_accessor  :name

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
  end


end
