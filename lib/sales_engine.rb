require_relative 'repo_builder'
require_relative 'object_builder'

class SalesEngine
  attr_reader :items, :merchant

  def initialize(repos = {})
    @items     = repos[:items]
    @merchants = repos[:merchant]
  end

  def self.from_csv(args) 
    se = SalesEngine.new
    rb = RepoBuilder.new(se)
    ob = ObjectBuilder.new

    arry_objects = ob.read_csv(args)
    repos = rb.build_repos(arry_objects)

    ob.assign_parents(repos)

  end
end
