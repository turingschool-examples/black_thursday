require_relative "/data/items"
require_relative "/data/merchants"

class SalesEngine
  attr_reader :items

  def initialize(csv_file)
    @csv_file = csv_file
  end

  def items
    @csv_file
  end
end
