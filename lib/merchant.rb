class Merchant
  attr_reader :id, :name, :repo, :created_at
  def initialize(data, repo)
    @id = data[:id].to_i
    @name = data[:name]
    @repo = repo
    unless data[:created_at].nil?
      @created_at = Time.parse(data[:created_at])
    end
  end

  def self.create_merchant(attributes, merchant_repo)
    data_hash = {}
    data_hash[:id] = merchant_repo.next_highest_merchant_id
    data_hash[:name] = attributes[:name]
    new(data_hash, merchant_repo)
  end

  def update_merchant(attributes)
    @name = attributes[:name]
  end
end
