# Merchant
class Merchant
  attr_reader :id,
              :name

  def initialize(merchant, parent = nil)
    @id = merchant[:id]
    @name = merchant[:name]
    @parent = parent
  end
end
