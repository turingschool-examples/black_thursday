class Merchant

  attr_reader :id,
              :name,
              :created_at

  attr_accessor :parent

  def initialize (row, parent = nil)
    @id           = row[:id].to_i
    @name         = row[:name]
    @created_at   = row[:created_at]
    @parent = parent
  end 
end
