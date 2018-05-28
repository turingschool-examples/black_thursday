class Merchant
  attr_reader :id, :created_at
  attr_accessor :name, :updated_at

  def initialize(merchant)
    @id = merchant[:id].to_i
    @name = merchant[:name]
    @created_at = merchant[:created_at]
    @updated_at = merchant[:updated_at]
  end

end
