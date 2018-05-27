require_relative 'item.rb'

class ItemRepository
  attr_reader :repository

  def initialize(file_contents)
    # @items = file_contents
    @repository = file_contents.map { |item| Item.new(item) }
  end

  # def make_repository
  #   @items.map do |item|
  #     Item.new(item)
  #   end
  # end

end
