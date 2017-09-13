require './lib/member'


class Merchant < Member

  attr_reader :id, :name
  def initialize(repo, fields)
    super(repo, fields)
    @id = fields[:id]
    @name = fields[:name]
  end

  def items
    repo.children(:items, id)
  end

end
