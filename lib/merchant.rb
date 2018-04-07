# this is merchant class
class Merchant
  attr_reader :id,
              :name
  def initialize(data)
    @id = data[:id]
    @name = data[:name]
  end
end
