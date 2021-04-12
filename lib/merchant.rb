class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(merchant_info)
    @id = merchant_info[:id]
    @name = merchant_info[:name]
    @created_at = Time.now
    @updated_at = Time.now
  end
end
