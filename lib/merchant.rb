class Merchant

  attr_reader :id,
              :name

  def initialize(datum)
    @id = datum[:id]
    @name = datum[:name]
  end

end
