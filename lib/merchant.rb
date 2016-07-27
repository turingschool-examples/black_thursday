class Merchant

  attr_reader :id,
              :name,
              :parent_repo

  def initialize(datum, parent_repo = nil)
    @id = datum[:id]
    @name = datum[:name]
    @parent_repo = parent_repo
  end

  def items
    parent_repo.pass_to_engine(@id)
  end

end
