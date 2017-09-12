class Merchant

  attr_reader :id,
              :name,
              :parent

  def initialize(hash, repo=nil)
    @id     = hash[:id].to_i
    @name   = hash[:name]
    @parent = repo
  end

  def items
    parent.items_of_merchant(id)
  end




end
