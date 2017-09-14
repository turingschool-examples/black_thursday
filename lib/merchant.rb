require_relative 'member'


class Merchant < Member

  attr_reader :name
  def initialize(repo, fields)
    super(repo, fields)
    @id = fields[:id].to_i
    @name = fields[:name]
  end

  def items
    repo.children(:items, id)
  end

end
