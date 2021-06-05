class Merchant
  attr_reader :id, :name, :repo
  def initialize(data, repo)
    @id = data[:id].to_i
    @name = data[:name]
    @repo = repo
  end

  def self.create_merchant(attributes)
    data_hash = {}
    #require "pry"; binding.pry
    data_hash[:id] = @repo.next_highest_merchant_id
    data_hash[:name] = attributes[:name]
    new(data_hash, @repo)
  end

  def update_merchant(id, attributes)
    @name = attributes[:name]
  end
end
