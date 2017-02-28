
require_relative "item_repository"
require_relative "merchant_repository"
require_relative "invoice_repository"
require_relative "invoice_item_repository"
require_relative "customers_repository"
require_relative "transaction_repository"
require "csv"
require 'pry'

class SalesEngine
  attr_accessor :items, :merchants, :invoices, :invoice_items, :transactions, :customers
  
  def self.from_csv(data)
    #files = hash.each_pair do |key, value|
      # @paths[key] = value

      #create a method, repo_creator?
        #def if_it_exists_make_repo

        
    se = SalesEngine.new
    se.items = ItemRepository.new(data[:items], se)
    se.merchants = MerchantRepository.new(data[:merchants], se)
    se.invoices = InvoiceRepository.new(data[:invoices], se) unless data[:invoices].nil?


    #Refactor to initialize with dynamic paths
    se.invoice_items = InvoiceItemRepository.new(se)
    # se.invoice_items.from_csv("./data/invoice_items.csv")
    se.invoice_items.from_csv("./data/invoice_items.csv")
    se.transactions = TransactionRepository.new(se)
    se.transactions.from_csv("./data/transactions.csv")
    se.customers = CustomerRepository.new(se)
    se.customers.from_csv("./data/customers.csv")
    se
  end

end

se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => "./data/invoices.csv" })
ir = se.items
mr = se.merchants
invr = se.invoices
cr = se.customers

invoice = invr.all[0]

# binding.pry


""






#####
#Notes
#####



  # {
  #   :items     => "./data/items.csv",
  #   :merchants => "./data/merchants.csv",
  # }


#=> seems to just return your MerchantRepo *object*

#SE will just read csv files and set up Item Repos and Merchant Repos
#- items and merchants initilialized as empty



#!! from_csv is a CLASS INSTANCE
# mod 2-er says to look up '*.self'

#from_csv
# Call class method on SE,
# pass in the paths
# instantiate IR and MR

#.items - returns IR object
#.merchants - returns MR objects
