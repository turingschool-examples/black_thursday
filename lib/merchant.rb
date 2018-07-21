class Merchant
  attr_reader :id
  attr_accessor :name

  def initialize(id_and_name)
    @name = id_and_name[:name]
    @id = id_and_name[:id]
  end
end
