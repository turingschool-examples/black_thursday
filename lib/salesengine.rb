require 'csv'
require './lib/merchantrepository'


class SalesEngine
  attr_reader :items, :merchants

  def self.from_csv(data)
    @merchants = Merchant_Repository.new
  end


end