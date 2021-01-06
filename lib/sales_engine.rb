class SalesEngine
  se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
  })
end

def items
  se[:item]
  output - item_repo
end

def merchants
  se[:merchant]
  output - merchant_repo
end
