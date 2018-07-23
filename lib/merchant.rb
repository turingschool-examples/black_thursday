class Merchant
  attr_accessor   :name

  attr_reader     :id,
                  :created_at,
                  :updated_at

  def initialize(merchant_hash)
    @name = merchant_hash[:name]
    @id = merchant_hash[:id].to_i
    @created_at = merchant_hash[:created_at]
    @updated_at = merchant_hash[:updated_at]
  end
end
