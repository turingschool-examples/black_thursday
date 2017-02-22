class SalesEngine
  attr_reader :items, :merchant

  def initialize
    @items = repos[:items]
    @merchants = repos[:merchant]
  end


  def self.from_csv(args)
    se = SalesEngine.new
    rb = RepoBuilder.new(se)
    ob = ObjectBuilder.new

    arry_objects = ob.read_csv(args)
    repos = rb.build_repos(arry_objects)
  end
end
