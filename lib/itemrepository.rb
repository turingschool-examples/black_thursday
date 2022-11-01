require_relative 'reposable'

class ItemRepository
  include Reposable

  attr_reader :all

  def initialize(all = [])
    @all = all
  end

  def find_by_name(name)
    all.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    all.select do |item|
      item.description.include? description
    end
  end
end