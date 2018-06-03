class Merchant
  attr_accessor :name,
                :updated_at
  attr_reader   :id,
                :created_at

  def initialize(attributes)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
  end
end
