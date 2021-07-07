
class Merchant
  attr_reader :id, :created_at
  attr_accessor :name, :updated_at

  def initialize(hash)
    @id = hash[:id].to_i
    @name = hash[:name]
    @created_at = Time.parse(hash[:created_at].to_s)
    @updated_at = Time.parse(hash[:updated_at].to_s)
  end
end
