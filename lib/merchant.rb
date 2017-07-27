class Merchant

  attr_reader :id,
              :name,
              :parent

  def initialize(hash, repo = nil)
    @id = hash[:id]
    @name = hash[:name]
    @parent = repo

  end
 



end
