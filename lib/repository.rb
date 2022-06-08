require_relative 'helper'
require_relative 'findable'
require_relative 'existable'

class Repository
  include Existable
  include Findable

  attr_accessor :all

  def initialize(file_path)
    @all = make_repo(file_path)
  end

  def make_repo(file_path)
    thing = evaluate
    repo = Array.new
    CSV.foreach(file_path, headers: true, header_converters: :symbol){|row| repo.push(thing.new(row))}
    repo
  end

  def inspect #for SpecHarness
  "#<#{self.class} #{@merchants.size} rows>"
  end
end
