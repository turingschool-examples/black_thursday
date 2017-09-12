class Merchant
  attr_reader :id, :name, :created_at, :updated_at

  def initialize(merchant)
    @id = merchant[:id]
    @name = merchant[:name]
    @created_at = merchant[:created_at]
    @updated_at = merchant[:updated_at]
  end

end
