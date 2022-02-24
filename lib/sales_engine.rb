require "./data/items"
require "./data/merchants"

class SalesEngine

  se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
  })

end
