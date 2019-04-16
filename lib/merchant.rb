require 'csv'
require 'bigdecimal'
require 'time'

class Merchant

  attr_reader :id

  attr_accessor :name

  def initialize(data)
    @id = data[:id]
    @name = data[:name]
  end

end
