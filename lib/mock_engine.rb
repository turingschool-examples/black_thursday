require_relative 'sales_engine.rb'

module MockEngine
  sales_engine = SalesEngine.new({
    items: './test/fixtures/items.csv',
    merchants: './test/fixtures/merchants_fix.csv'
    })
end
