class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :parent

  def initialize(attributes, parent = "")
    @id         = attributes[:id].to_i
    @name       = attributes[:name]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
    @parent     = parent
  end
end
