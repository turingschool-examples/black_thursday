class Merchant
  attr_accessor :attributes_hash,
                :id ,
                :name,
                :updated_at
  def initialize(attributes_hash)
   @attributes_hash = attributes_hash
    @id = attributes_hash[:id].to_i
    @name = attributes_hash[:name]
    @created_at = Time.now
    @updated_at = Time.now

  end





end
