require "pry"

class Merchant

  attr_reader :name, :id, :repo

  def initialize(hash)
    @name  = hash[:name]
    @id = hash[:id]
    @repo = repo
  end
end
