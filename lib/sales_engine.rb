require "csv"

class SalesEngine
  def self.from_csv({})
    {merchants: CSV.open "./data/merchants.csv", headers: true
    items: CSV.open "./data/items.csv", headers: true}
  end
end
