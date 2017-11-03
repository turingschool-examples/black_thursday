require 'csv'

class Merchant

  attr_reader :name, :repository, :id

  def initialize(data, repository)
    @name = data[:name]
    @id = data[:id].to_i
    @repository = repository
  end

  def items
    repository.find_item(@id)
  end



end
