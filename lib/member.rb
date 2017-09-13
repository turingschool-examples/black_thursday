class Member

  attr_reader :id, :repo
  def initialize(repo)
    @repo = repo
  end

  def ==(other)
    @id == other.id
  end

end
