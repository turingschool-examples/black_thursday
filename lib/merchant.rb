require 'time'

class Merchant
  attr_reader   :id
  attr_accessor :name,
                :created_at,
                :updated_at

  def initialize(merchant_hash)
    @id = merchant_hash[:id]
    @name = merchant_hash[:name]
    @created_at = Time.new.getutc
    @updated_at = Time.new.getutc
  end
end
