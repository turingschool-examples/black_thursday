require 'time'
class Merchant
  attr_accessor :attributes_hash,
                :id,
                :name,
                :updated_at
  def initialize(attributes_hash)
   @attributes_hash = attributes_hash
    @id = attributes_hash[:id].to_i
    @name = attributes_hash[:name]
    @created_at = Time.parse(attributes_hash[:created_at].to_s)
    @updated_at = Time.parse(attributes_hash[:updated_at].to_s)
  end





end
