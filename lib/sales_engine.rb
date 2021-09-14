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
  result_array = []
  rows = CSV.read(@merchants,headers: true)
  rows.each do |k,v|
    next if k == "created_at"
    next if k == "updated_at"
    merchant_hash = {}
    merchant_hash[k] = v
    result_array.push(Merchant.new(merchant_hash))
  end
  mr = MerchantsRepository.new(result_array)
 end
end
