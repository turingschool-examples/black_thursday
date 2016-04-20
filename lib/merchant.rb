require_relative 'sales_engine'

class Merchant
  attr_reader :id, :name, :sales_engine

  def initialize(data, sales_engine)
    @id = data[:id].to_i
    @name = data[:name]
    @sales_engine = sales_engine
  end

end
