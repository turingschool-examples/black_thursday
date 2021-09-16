class SalesEngine

  attr_reader :merchants,
              :items

<<<<<<< HEAD
  def initialize(merch_item_hash)
    @merchants = MerchantsRepository.new(merch_item_hash[:merchants])
    @items = ItemRepository.new(merch_item_hash[:items])
=======
  def items
    items_array = []
    items_table = CSV.read(@items, headers: true)
    items_table.each do |row|
      items_hash = {}
      row_headers = row.headers
      items_hash[row_headers[0].to_sym] = row[0]
      items_hash[row_headers[1].to_sym] = row[1]
      items_hash[row_headers[2].to_sym] = row[2]
      items_hash[row_headers[3].to_sym] = row[3]
      items_hash[row_headers[4].to_sym] = row[4]
      items_hash[row_headers[5].to_sym] = row[5]
      items_hash[row_headers[6].to_sym] = row[6]
      items_array.push(Item.new(items_hash))
    end
    ItemRepository.new(items_array)
>>>>>>> 4547c51c2ccc47623ccade40ea258bd77301cfa6
  end


end
