require 'time'


class Merchant
  attr_reader   :id,
                :created_at
                
  attr_accessor :updated_at,
                :name
  
  def initialize(hash)
    @id = hash[:id].to_i
    @name = hash[:name].to_s
    @created_at = Time.parse(hash[:created_at].to_s)
    @updated_at = Time.parse(hash[:updated_at].to_s)
  end


end