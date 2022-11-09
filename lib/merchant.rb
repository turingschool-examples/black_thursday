require 'requirements'

class Merchant
  attr_reader :id,
              :name,
              :created_at

  def initialize(info, repo)
    @id = info[:id].to_i
    @name = info[:name]
    @created_at = Time.parse(info[:created_at])
    @repo = repo
  end
  
  def update(attributes)
    @name = attributes[:name] if !attributes[:name].nil?
  end

end