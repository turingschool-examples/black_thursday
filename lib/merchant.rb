class Merchant

  attr_reader :id

  attr_accessor :name

  def initialize(info)
    @id = info[:id]
    @name = info[:name]
  end
end
