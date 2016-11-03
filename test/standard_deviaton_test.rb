require 'minitest/autorun'
require 'minitest/pride'
require 'standard_deviation'

  class StandardDeviationTest < Minitest::Test
    attr_reader   :set_1,
                  :set_2

  def setup
    @set_1 = [3,4,5]
    @set_2 = [5,10,12,18,30]
  end

  
  end