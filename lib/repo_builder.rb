class RepoBuilder
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def build_repos(arry_objects)
    [ MerchantRepository.new(arry_objects[:merchant], sales_engine) ]
  end
end
