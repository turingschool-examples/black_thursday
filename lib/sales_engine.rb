require_relative 'repo_builder'
require_relative 'object_builder'
require 'pry'

class SalesEngine

  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(repos = {})
    @merchants     = repos[:merchants]
    @items         = repos[:items]
    @invoices      = repos[:invoices]
    @invoice_items = repos[:invoice_items]
    @transactions  = repos[:transactions]
    @customers     = repos[:customers]
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
    @merchants     = repos[0]
    @items         = repos[1]
    @invoices      = repos[2]
    @invoice_items = repos[3]
    @transactions  = repos[4]
    @customers     = repos[5]
  end
end
