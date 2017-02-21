require 'csv'
# require_relative '../data/merchants'
# require_relative '../data/items'



class SalesEngine

  attr_reader :files

  def initialize
    @files = {}
  end


  def self.from_csv(file)
  key =  File.basename(file, ".csv").to_sym

  @files[key] = file
require "pry"; binding.pry
  end



#
# se = SalesEngine.from_csv({
#   :items     => "./data/items.csv",
#   :merchants => "./data/merchants.csv",
# })
#calling a class method

end
