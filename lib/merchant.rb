class Merchant

  attr_reader :id,
              :name,
              :created,
              :updated
              
  def initialize(details)
    @id = details[:id].to_i
    @name = details[:name]
    @created = details[:created_at]
    @updated = details[:updated_at]
  end

  

end