class Merchant
  attr_accessor :id,
                :name,
                :created_at,
                :updated_at

  def initialize(merchant_info)
    @id = merchant_info[:id].to_i
    @name = merchant_info[:name]
    @created_at = Time.parse(merchant_info[:created_at].to_s)
    @updated_at = Time.parse(merchant_info[:updated_at].to_s)
  end

  def update_name(attributes)
    @name = attributes[:name]
  end
end
