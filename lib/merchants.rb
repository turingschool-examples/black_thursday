class Merchant
  attr_accessor :id,
                :name,
                :repository

  def initialize(attributes, repository)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @repository = repository
  end

  def items(id)
    @repository.find_items_by_id(@id)
  end
end
