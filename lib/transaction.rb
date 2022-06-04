class Transaction
  attr_reader :id
  
  def initialize(info)
    @id = info[:id]
  end
end
