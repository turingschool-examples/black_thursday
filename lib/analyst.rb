require 'CSV'
require './lib/items'
require 'time'
require 'bigdecimal'
require 'bigdecimal/util'
require './lib/sales_engine'

class Analyst

  def initialize(engine)
    @engine = engine
  end

end
