require_relative 'helper_methods'

class SalesAnalyst
  include HelperMethods
  attr_reader :items, :merchants, :engine

  def initialize(item_repo, merchant_repo, engine)
    @items = item_repo
    @merchants = merchant_repo
    @engine = engine
  end

end
