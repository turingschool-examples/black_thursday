class Merchant

  attr_reader :id, :name

  attr_writer :name

  def initialize(id,name)
    @id = id
    @name = name
  end

end
