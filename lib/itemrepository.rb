require_relative 'reposable'

class ItemRepository
  include Reposable

  attr_reader :all

  def initialize(all = [])
    @all = all
  end
end