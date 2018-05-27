require_relative 'item.rb'

class ItemRepository
  attr_reader :repository

  def initialize(file_contents)
    @repository = file_contents.map { |item| Item.new(item) }
  end

  def all
    @repository
  end

  def find_by_id(id)
    @repository.find { |item| item.item_specs[:id] == id}
  end

end
