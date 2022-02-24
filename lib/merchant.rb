# Merchant class
class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(attr)
    @id = attr[:id]
    @name = attr[:name]
    @created_at = attr[:created_at].to_s
    @updated_at = attr[:updated_at].to_s
  end
end
