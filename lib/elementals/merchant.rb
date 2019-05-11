# merchant class
class Merchant
  attr_reader :id
  attr_accessor :name

  def initialize(attrs)
    @id = attrs[:id].to_i
    @name = attrs[:name]
  end
end
