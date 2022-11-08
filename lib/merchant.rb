class Merchant
  attr_reader :id,
              :name

  def initialize(info, repo)
    @id = info[:id].to_i
    @name = info[:name]
    # @repo = repo
  end
  
  def update(attributes)
    @name = attributes[:name] if !attributes[:name].nil?
  end

end