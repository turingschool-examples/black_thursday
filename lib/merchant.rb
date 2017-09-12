class Merchant

  attr_reader :id,
              :name

  def initialize(information)
    @id = information[:id]
    @name = information[:name]
  end

end
