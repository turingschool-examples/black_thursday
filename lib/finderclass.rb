# This will consist of class methods for finder functionality

require 'pry'

class FinderClass

  # if this was a module, maybe this would work
  # def find_by(method, data, repo = @all)

  def self.find_by(repo, method, data)
    repo.find {|object| object.send(method) == data }
  end # returns an object / the first object

  def self.find_all_by(repo, method, data)
    repo.find_all {|object| object.send(method) == data }
  end # returns an array of objects

  def self.find_max(repo, method)
    repo.max_by { |object| object.send(method) }
  end # returns an object (not the max value itself)

  def self.find_by_range(repo, method, range)
    # range = range.to_a   #range comes in as (0..2)
    low = range.first
    high = range.last
    # TEST difference between range types (0..2) vs (0...2)


  end

  # -------------------------------------


end
