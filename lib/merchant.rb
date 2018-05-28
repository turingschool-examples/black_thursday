class Merchant
  attr_reader   :id,
                :created_at
  attr_accessor :name,
                :updated_at



  def initialize(attributes)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
  end
end
