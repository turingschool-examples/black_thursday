class Merchant
  attr_reader   :id,
                :name,
                :created_at,
                :updated_at

  def initialize(info, merchant_repository = "")
    @id = info[:id]
    @name = info[:name]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
  end

end
