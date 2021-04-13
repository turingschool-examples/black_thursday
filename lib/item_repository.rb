
class ItemRepository
  attr_reader :filename, :all

  def initialize(filename)
    @filename = filename
    @all = generate_items
  end

  def generate_items
    # read from filename
    # separate into items by id
    handle = File.open(@filename, 'r')
    items = handle.read
    handle.close
    items.split(/(?=\d{9})/)
    require "pry"; binding.pry
  end
end
