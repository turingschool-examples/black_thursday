class Merchant

  attr_reader :id,
              :name,
              :parent

  def initialize(data, repo=nil)
    @id     = data[:id].to_i
    @name   = data[:name]
    @parent = repo
  end

  def items
    parent.items_of_merchant(id)
  end
end
