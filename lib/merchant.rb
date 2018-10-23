class Merchant
  attr_reader :id
  attr_accessor :name
  def initialize(args)
    @id = args[:id]
    @name = args[:name]
  end
end
