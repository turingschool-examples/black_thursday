class Merchant

attr_reader :id, :name

  def initialize(fields)
    @id = fields[:id]
    @name = fields[:name]
  end


end
