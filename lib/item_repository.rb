require './lib/searching'

class ItemRepository
  include Searching

  def initialize(file_path)
    @file_path = file_path
  end

  def all
    data.map {|row| Item.new(row)}
  end
end
