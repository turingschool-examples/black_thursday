class Merchant
  attr_reader :id, :name

  def initialize(row)
    @id = row[:id]
    @name = row[:name]
  end
end
