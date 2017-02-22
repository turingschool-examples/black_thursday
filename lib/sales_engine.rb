require_relative 'sales_engine_repository_creators'

class SalesEngine
  include RepositoryCreators

  attr_reader :merchants,
              :items
      
  def initialize(files)
    @merchants = create_merchant_repository(files[:merchants])
    @items = #call method that creates item repository
  end

  def self.from_csv(files)
    new(files)
  end

end