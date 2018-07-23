require_relative 'item'
require './lib/repository_module'


class ItemRepository

  attr_reader :repository

  include RepositoryModule

  def initialize(data_file)
    @repository = data_file.map {|item| Item.new(item)}
  end

  def all
    @repository.find_all do |element|
      element
    end
  end

  def find_by_id(id)
    @repository.find do |item|
      item.attributes[:id] == id
    end
  end

  def find_by_name(name)
    @repository.find do |item|
      item.attributes[:name] == name
    end
  end


end
