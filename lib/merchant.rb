class Merchant
  attr_accessor :id, :name, :repo
  def initialize(attributes, repo = nil)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @repo = repo
  end

  def items
    @repo.find_all_by_merchant_id(id)
  end
end
