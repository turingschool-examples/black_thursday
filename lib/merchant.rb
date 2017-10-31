require "./lib/merchant_repo"

class Merchant
  attr_reader :id,
              :name,
              :repository

  def initialize(row, parent)
    @id   = row[:id]
    @name = row[:name]
    @repository = parent
  end
end
