# this is merchant class
class Merchant
  attr_reader :id,
              :name
  def initialize(data)
    @id = data[:id].to_i
    @name = data[:name]
  end
end
