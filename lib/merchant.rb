require 'pry'
require 'csv'

class Merchant
  attr_reader :id,
              :name,
              :parent

  def initialize(hash, merchant_repository_instance = nil)
    @id     = hash[:id]
    @name   = hash[:name]
    @parent = merchant_repository_instance
  end

end
