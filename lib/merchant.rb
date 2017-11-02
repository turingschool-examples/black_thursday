
class Merchant
  attr_reader :id,
              :name,
              :repository

  def initialize(row, parent)
    @id   = row[:id]
    @name = row[:name]
    @repository = parent
  end

  def items
    puts repository.find_items(self.id)
  end

end
