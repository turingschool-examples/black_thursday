require 'csv'

class ItemRepository
  def initialize(csv)
    @csv = CSV.read(csv)
  end
end
