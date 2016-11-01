class Merchant
  attr_reader :id, 
              :name
  
  def initialize(merchant_info = nil)
    return if merchant_info.to_h.empty?
    @id   = merchant_info.to_h[:id].to_i
    @name = merchant_info.to_h[:name].to_s
  end

end