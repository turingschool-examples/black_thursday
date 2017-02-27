require_relative 'repo_builder'
require_relative 'object_builder'
require 'pry'

class SalesEngine
  attr_reader :items, :merchants, :invoices, :transactions

  def initialize(repos = {})
    @merchants    = repos[:merchants]
    @items        = repos[:items]
    @invoices     = repos[:invoices]
    @transactions = repos[:transactions]
  end

  def self.from_csv(args)
    se = SalesEngine.new()
    rb = RepoBuilder.new(se)
    ob = ObjectBuilder.new
    arry_objects = ob.read_csv(args)
    repos = rb.build_repos(arry_objects)

    ob.assign_parents(repos)
    se.set_variables(repos)
    return se
  end

  def set_variables(repos)
    @merchants    = repos[0]
    @items        = repos[1]
    @invoices     = repos[2]
    @transactions = repos[3]
  end
end
