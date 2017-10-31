<<<<<<< HEAD

class Merchant

  attr_reader :id
              :name

  def initialize(row)
    @id   = row[:id]
    @name = row[:name]
  end

=======
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
>>>>>>> 943eb9f012d5b48b06ef5c06aa0f586b7c20960a
end
