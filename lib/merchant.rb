class Merchant
  attr_reader :id, :created_at
  attr_accessor :name, :updated_at

  def initialize(merchant)
    @id = merchant[:id].to_i
    @name = merchant[:name]
    @created_at = Time.parse(merchant[:created_at].to_s)
    @updated_at = Time.parse(merchant[:updated_at].to_s)
  end
end
