class Merchant

  attr_accessor :id, :name, :created_at, :updated_at

  def initialize(attributes)
    @id =           attributes[:id]
    @name =         attributes[:name]
    @created_at =   attributes[:created_at]
    @updated_at =   attributes[:updated_at]
  end
end
