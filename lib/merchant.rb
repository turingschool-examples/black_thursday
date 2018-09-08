require 'pry'

class Merchant

  attr_reader :id,
              :name

  def initialize(data)
    @id = args[:id]
    @name = args[:name]
  end

end
