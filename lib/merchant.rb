class Merchant
  attr_accessor :id,
                :name,
                :repo

  def initialize(info, repo)
    @id = info['id'].to_i
    @name = info['name']
    @repo = repo
  end

  def update_merchant(attributes)
    @name = attributes['name']
  end
end
