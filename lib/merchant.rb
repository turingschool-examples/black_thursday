class Merchant
  attr_accessor :id,
              :name,
              :created_at,
              :updated_at
  attr_reader :repo,
              :items

  def initialize(data, repo)
    @data = data
    @repo = repo
    @id = data[:id]
    @name = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @items = []
  end

  def update(attributes)
    @name        = attributes[:name] if attributes[:name]
    @repo        = attributes[:repo] if attributes[:repo]
    @updated_at  = Time.now
  end

  def find_items
    
  end
end
