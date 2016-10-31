class Merchant
  attr_reader :id, 
              :name
  
  def initialize(merchant_info = nil)
    raise ArgumentError.new(error) unless merchant_info_clean?(merchant_info)
    @id   = merchant_info[:id]
    @name = merchant_info[:name]
  end

  def merchant_info_clean?(merchant_info)
    merchant_info.to_h.any?           && 
    merchant_info[:id].is_a?(Integer) &&
    merchant_info[:name].is_a?(String)
  end

  def error
    "Error: :id must be a number and :name must be a string."
  end

end