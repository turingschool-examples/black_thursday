
class Merchant
  attr_reader :id
  attr_accessor :name

  def initialize(info)
    @name = info[:name]
    @id = info[:id]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
  end

end
