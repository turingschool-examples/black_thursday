class Merchant
  attr_accessor :id,
                :name,
                :created_at,
                :updated_at

  def initialize(hash)
    @id   = hash[:id].to_i
    @name = hash[:name]
    @created_at = if hash[:created_at].class == String
                    Time.parse(hash[:created_at])
                  end
    @updated_at = if hash[:created_at].class == String
                    Time.parse(hash[:created_at])
                  end
  end
end
