class Merchant

  attr_reader :id, :name

  def initialize(args)
    @id = args[:id].to_i
    @name = args[:name]
    @sales_engine = args[:sales_engine]
  end

end
