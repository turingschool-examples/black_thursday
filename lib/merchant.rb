class Merchant
  attr_reader :name,
              :id,
              :parent,
              :created_at,
              :updated_at

  def initialize(info = {}, parent=nil)
    @name       = info[:name]
    @id         = info[:id]
    @parent     = parent
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
  end
end
