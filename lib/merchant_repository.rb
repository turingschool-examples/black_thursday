require 'csv'
require_relative './merchant'
require_relative './repository_methods'


class MerchantRepository

  attr_accessor :collection, :child

  def initialize(path, sales_engine)
    @collection = Hash.new
    @child = Merchant
    populate_repository(path, sales_engine)
  end

  include RepositoryMethods

  def inspect
    "#<#{self.class} #{@collection.size} rows>"
  end

end
