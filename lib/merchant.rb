class Merchant

  attr_reader :id,
              :name,
              :repository

  def initialize(attributes, repository)
    @id   = attributes[:id].to_i
    @name = attributes[:name]
    @repository = repository
  end

  def items
    repository.all_merchant_items(id)
  end
end
