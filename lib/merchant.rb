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

  def update(symbol, new_value)
    instance_var_to_string
    if @id_1 == symbol.to_s
      @id = new_value
    elsif @name_1 == symbol.to_s
      @name = new_value
    end
  end

  def instance_var_to_string
    @repo_1 = "repo"
    @id_1 = "id"
    @name_1 = "name"
  end

end
