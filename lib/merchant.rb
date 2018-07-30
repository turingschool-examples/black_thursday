class Merchant
  attr_reader :id,
              :created_at
  attr_accessor :name,
                :updated_at

  def initialize(information)
    @name = information[:name]
    @id = information[:id].to_i
    @created_at = Time.parse(information[:created_at].to_s)
    @updated_at = Time.parse(information[:updated_at].to_s)
  end
end
