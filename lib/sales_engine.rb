# class SalesEngine
#   attr_reader :items, :merchants
#   def initialize
#       @items = []
#     @merchants = []
#   end
#
#   def self.from_csv(path_hash)
#     path_hash.each do |name, path|
#       name = CSV.read(path, headers: true, header_converters: :symbol)
