class Merchant
  attr_reader :id
  attr_accessor :name

  def initialize(details)
    @id = details[:id]
    @name = details[:name]
  end

end
