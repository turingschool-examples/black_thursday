require 'time'

class Merchant
  attr_reader  :id,
               :created_at

  attr_accessor :name,
                :updated_at

  def initialize(merchant_data)
    @name = merchant_data[:name]
    @id = merchant_data[:id].to_i
    @created_at = Time.parse(merchant_data[:created_at].to_s)
    @updated_at = Time.parse(merchant_data[:updated_at].to_s)
  end
end
