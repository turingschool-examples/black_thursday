class Merchant
  attr_accessor :id,
              :name,
              :created_at,
              :updated_at
  attr_reader :repo

  def initialize(data, repo)
    @repo = repo
    @id = data[:id]
    @name = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def update(attribute)
    instance_var_to_string
    if @id_1 == attribute.keys[0].to_s
      @id = attribute.values[0]
    elsif @name_1 == attribute.keys[0].to_s
      @name = attribute.values[0]
    end
  end

  def instance_var_to_string
    @repo_1 = "repo"
    @id_1 = "id"
    @name_1 = "name"
  end

end
