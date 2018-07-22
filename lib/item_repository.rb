require_relative 'item.rb'
# require_relative 'repo_helper'

class ItemRepository
  attr_reader :item_repo

  def initialize(file_contents)
    @item_repo = file_contents.map do |item|
      Item.new(item)
    end
  end




end
