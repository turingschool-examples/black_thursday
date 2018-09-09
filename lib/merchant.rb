require 'time'

class Merchant
  attr_accessor :id,
                :name,
                :created_at,
                :updated_at

  def initialize(merchant_hash)
    @id = merchant_hash[:id]
    @name = merchant_hash[:name]
    @created_at = Time.new.getutc
    @updated_at = Time.new.getutc
  end
end
