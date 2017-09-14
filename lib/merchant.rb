class Merchant

  attr_reader :id,
              :name,
              :parent

  def initialize(information, parent = nil)
    @id = information[:id]
    @name = information[:name]
    @parent = parent
  end

end
