# Merchant class
class Merchant
  attr_reader :id,
              :name

  def initialize(attr)
    @id = attr[:id]
    @name = attr[:name]
  end
end
