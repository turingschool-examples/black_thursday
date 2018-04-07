# this is merchant class
class Merchant
  attr_reader :id,
              :created_at
  attr_accessor :name,
                :updated_at
  def initialize(data)
    @id = data[:id].to_i
    @name = data[:name]
    @updated_at = data[:updated_at]
    @created_at = data[:created_at]
  end
end
