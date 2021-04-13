# silence hound
class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(merchant_info)
    @id = merchant_info[:id]
    @name = merchant_info[:name]
    @created_at = if merchant_info[:created_at] != nil
      merchant_info[:created_at]
    else
      Time.now
    end
    @updated_at = if merchant_info[:updated_at] != nil
      merchant_info[:updated_at]
    else
      Time.now
    end
  end
end
