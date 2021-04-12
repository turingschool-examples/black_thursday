require './lib/sales_engine'
require './lib/item'
require './lib/merchant'

SalesEngine::from_csv({
                        merchant: './data/merchants.csv'
                     })