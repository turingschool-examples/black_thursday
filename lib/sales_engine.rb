# frozen_string_literal: true

require './lib/file_loader.rb'
require_relative 'item_repository.rb'
require_relative 'item.rb'

# This class is the heart of the project. It contains references to the item and
# merchant repositories, which contain the references to the items and
# merchants.
class SalesEngine
  include FileLoader

  attr_reader :load_path
  def initialize(load_path)
    @load_path = load_path
  end

  # Here we create a new SalesEngine object with the load paths specified in the
  # spec, or any other load path we want. We load from CSV files, hence the
  # name. The paths will be sent as a hash, which will be hadled by the
  # load_path method form the FileLoader module. The new SalesEngine object
  # is instantiated this way
  def self.from_csv(load_path)
    SalesEngine.new(load_path)
  end

  # This conditional checks to see if @items has been defined as a new
  # repository and if it has not been defined it runs the load_file method
  # from the FileLoader module that loads in the CSV.
  def load_items
    loaded_file = load_file(load_path[:items])
    @load_items ||= ItemRepository.new(loaded_file, self)
  end

  def load_merchants
    loaded_file = FileLoader.load_file(load_path[:merchants], self)
    @load_merchants ||= MerchantRepository.new(loaded_file)
  end
end

x = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})
x.load_items
