class Merchant
  attr_reader :id,
              :name,
              :repo

  def initialize(merchant_hash, repo)
    @id = merchant_hash['id'].to_i
    @name = merchant_hash['name']
    @repo = repo
  end

  def to_hash
    self_hash = Hash.new
    self_hash[:id] = @id
    self_hash[:name] = @name
    self_hash
  end
end
