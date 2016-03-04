class Merchant
  attr_reader :id, :name, :repository

  def initialize(merchant_hash, repository)
    @repository = repository
    @id = merchant_hash[:id].to_i
    @name = merchant_hash[:name]
  end

  def items
    @repository.find_items(@id)
  end

end
