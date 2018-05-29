class Merchant
  # id,name,created_at,updated_at
  attr_reader :id
  attr_accessor :name

  def initialize(args)
    @id = args[:id].to_i
    @name = args[:name]
    @created_at = args[:created_at]
    @updated_at = args[:updated_at]
  end
end
