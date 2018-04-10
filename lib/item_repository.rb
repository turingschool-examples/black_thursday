# Item Repository
require 'CSV'
class ItemRepository
  # include Repository
  def initialize(path, parent)
    @parent = parent
    @contents = []
    load_path(path)
  end

  def load_path(path)
  #   # CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
  #   #   @contents << Item.new(row, self)
    end
  # end
end
