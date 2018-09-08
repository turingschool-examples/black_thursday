require 'pry'

class Merchant

  attr_reader :id,
              :name

  def initialize(args)
    @id = args[:id]
    @name = args[:name]
  end

end
