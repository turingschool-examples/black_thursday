require './lib/merchant_repository'

class Merchant
  attr_reader :id,
              :name

  def initialize(data, repository)
    @repository = repository
    @id = data[:id]
    @name = data[:name]
  end
end
