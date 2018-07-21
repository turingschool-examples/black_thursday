require_relative './merchant_repository'

class SalesEngine

  attr_reader     :location


  def initialize(location)
    @file_loader = FileLoader.new(location)
    @location = location
  end

  def self.from_csv(location)
    SalesEngine.new(location)
  end

end
