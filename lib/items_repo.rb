require 'CSV'
require 'pry'
require './lib/item'
require './lib/black_thursday_helper'

class ItemsRepo
  include BlackThursdayHelper

  def initialize(file_path)
    @collections = []
    populate(file_path)
  end

  def populate(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |params|
      @collections << Item.new(params)
    end
  end

  def find_all_with_description(description)
    @collections.find_all do |object|
      object.name.downcase.include? (description.downcase)
    end
  end

  # def all
  #  @items
  # end

end
