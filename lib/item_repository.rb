require 'CSV'

class ItemRepository
  attr_reader :contents,
              :parent

  def initialize(path, parent)
    @contents = []
    @parent = parent
    load_path(path)
  end

  def load_path(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @contents << Item.new(row, self)
    end
  end
end
