# require 'csv'
# require './merchant'
# require './data/merchants'

# module MerchantRepository
#   @@file_name = "sample.csv"
#   def self.all
#     rows = CSV.read(@@file_name, headers: true)
#     empty_array = []
#     empty_array << rows.by_row
#
#     p empty_array
#   end

#sales engine reads files and instantiates our merchanrepo and itemrepo
#merchant/itemrepo should take in array of hashes and then create an array of instances
#merchant/itemrepo should have methods to create, read, update, delete, (CRUD) etc.
#merchant/item just holds attributes

# sales engine

#repositories are similar to database communication layer
#
