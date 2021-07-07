class Merchant
  attr_reader :id,
              :created_at
  attr_accessor :name

  def initialize(hash)
    @id = hash[:id].to_i
    @name = hash[:name]
    @created_at = hash[:created_at]
  end

  def time
    Time.parse(@created_at.to_s)
  end
  
end
