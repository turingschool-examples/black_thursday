require 'CSV'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class Repository

  def initialize(path)
    parse_csv(path)
    #take action of use data to create the objects that this repo keeps track of
  end


end
