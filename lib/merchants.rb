class Merchant
  attr_accessor :id,
                :name,
                :repository

  def initialize(attributes)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @repository = attributes[:repository]
  end

  def items(id)
    @repository.find_items_by_id(@id)
  end
end
