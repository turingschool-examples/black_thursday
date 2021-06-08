class Merchant

  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repo

  def initialize(attributes, repo)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
    @repo = repo
  end

  def new_id(rule)
    @id = rule
  end

  def update_name(new_name)
    @name = new_name
  end

  def update_time
    @updated_at = Time.now
  end
end
