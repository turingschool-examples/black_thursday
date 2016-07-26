class Merchant

  attr_reader :id,
              :name,
              :parent_repo

  def initialize(datum, parent_repo)
    @id = datum[:id]
    @name = datum[:name]
    @parent_repo = parent_repo
  end

end
