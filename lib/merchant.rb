require "pry"

class Merchant

  attr_reader :name, :id, :repo

  def initialize(name = "", id, repo)
    @name  = name
    @id = id
    @repo = repo
  end
end
