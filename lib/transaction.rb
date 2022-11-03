class Transaction
  attr_accessor :id

  def initialize(data)
    @id = data[:id].to_i
  end
end