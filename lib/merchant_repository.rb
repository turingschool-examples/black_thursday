require 'csv'
require_relative './merchant'
require_relative './repository_methods'


class MerchantRepository

  attr_accessor :collection, :child

  def initialize(path)
    @collection = Hash.new
    @child = Merchant
    populate_repository(path)
  end

  include RepositoryMethods

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
