class Merchant

  attr_reader :id

  attr_accessor :name

  def initialize(info)
    @id = info[:id].to_i
    @name = info[:name]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
  end
end
