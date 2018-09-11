require 'time'

class Merchant
  attr_reader   :id
  attr_accessor :name,
                :created_at,
                :updated_at

  def initialize(merchant_hash)
    @id = merchant_hash[:id]
    @name = merchant_hash[:name]
    @created_at = merchant_hash[:created_at]
    @updated_at = merchant_hash[:updated_at]
  end

end
