require_relative './file_loader'
require_relative './merchant_repository'

class SalesEngine

  attr_reader     :location

  def self.from_csv(location)
    SalesEngine.new(location)
  end

  def initialize(location)
    @file_loader = FileLoader.new(location)
    @location = location
  end


end
