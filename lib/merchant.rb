class Merchant
  attr_reader :id, 
              :name
  
  def initialize(merchant_info = nil)
    return unless merchant_info
    @id   = merchant_info.to_h[:id]
    @name = merchant_info.to_h[:name]
  end

end