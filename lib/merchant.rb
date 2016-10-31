class Merchant
  #it's going to parse the merchant CSV
  #each row of merchant CSV will be accessible by name, id, created_at, updated_at
  #returns the name of the merchant and id
  attr_reader :name,
              :id

  def initialize(row)
    @id   = row[:id]
    @name = row[:name]
  end
end
