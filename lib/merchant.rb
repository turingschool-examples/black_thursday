class Merchant
  attr_reader :id, :name, :repo
  def initialize(data, repo)
    @id = data[:id]
    @name = data[:name]
    @repo = repo
  end
end
