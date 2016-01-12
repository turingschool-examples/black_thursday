# require 'controller'
require 'csv'

class SalesEngine
  attr_reader :file, :command, :value

  def initialize(command = nil, value = nil, *file)
    @file = file
    @command = command
    @value = value
  end

  def parse_request

  end

  def all
  end
end


#
# a method that parses request, that then sends to controller. class
# on this method, initialize Controller.new
#



# se = SalesEngine.new(*files, find_by_id, 10)
# se.saleanalysis.top_performers
