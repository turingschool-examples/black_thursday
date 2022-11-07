class Merchant
  attr_accessor :name
  attr_reader :id, :created_at

  def initialize(merchant_info)
    @id = merchant_info[:id].to_i
    @name = merchant_info[:name]
    @created_at = Time.parse(merchant_info[:created_at].to_s)
  end


end