class Merchant
  attr_accessor :id,
                :name

  def initialize(info)
    @id = info[:id]
    @name = info[:name]
  end
end
