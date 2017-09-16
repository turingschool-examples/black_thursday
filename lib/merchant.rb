require_relative 'repository/record'


class Merchant < Repository::Record

  attr_reader :name
  def initialize(repo, fields)
    super(repo, fields)
    @name = fields[:name]
  end

  def items
    repo.children(:items, id)
  end

end
