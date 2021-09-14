class SalesEngine
 attr_reader :merchants,
             :items

  # @@merchants = merch_item_hash[:merchants]
  # @@items = merch_item_hash[:items]

 def initialize(merch_item_hash)
   @merchants = merch_item_hash[:merchants]
   @items = merch_item_hash[:items]
 end

 # def items
 #   result_array = []
 #   rows = CSV.read(@items,headers: true)
 #   rows.each do |row|
 #     result_array.push(Items.new(row))
 #   end
 #   mr = ItemsRepository.new(result_array)
 # end
 #
 def merchants
   #returns an instance of MerchantsRepository
  merch_array = []
  merch_table = CSV.read("./data/items.csv",headers: true)
  merch_table.each do |row|
    merch_hash = {}
    row_header = row.headers
    merch_hash[row_header[0].to_sym] = row[0]
    merch_hash[row_header[1].to_sym] = row[1]
    merch_array.push(Merchant.new(merch_hash))
  end
  mr = MerchantsRepository.new(merch_array)
 end
end
