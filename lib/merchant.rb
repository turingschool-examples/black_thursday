class Merchant
  attr_reader :id,
              :name

  def initialize(info, repo)
    @id = info[:id]
    @name = info[:name]
    # @repo = repo
  end
  
end