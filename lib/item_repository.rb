require_relative 'item.rb'
require_relative 'repo_helper'

class ItemRepository
  include RepoHelper
  attr_reader :repo

  def initialize(file_contents)
    @repo = file_contents.map do |item|
      Item.new(item)
    end
  end

  def find_all_with_description(description)
    all_items = @repo.select do |item|
      item.description.downcase.include?(description.downcase)
    end
    return all_items
  end

  def find_all_by_price(price)
    all_items = @repo.select do |item|
      item.unit_price == price
    end
    return all_items
  end

  def find_all_by_price_in_range(range)
    all_items = @repo.select do |item|
      range.include?(item.unit_price)
    end
    return all_items
  end




end
