class Merchant

  attr_reader :id, :name

  def initialize(data, sales_engine)
    @id = data[:id].to_i
    @name = data[:name]
    @sales_engine = sales_engine
  end

end
