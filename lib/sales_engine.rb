class SalesEngine

  def initialize(merch_item_hash)
    @merchants = merch_item_hash[:merchants]
    @items = merch_item_hash[:items]
  end

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
    #ItemRepository.new(items_array)
    items_array
  end

  def merchants
  #returns an instance of MerchantsRepository
    merch_array = []
    merch_table = CSV.read(@merchants, headers: true)
    merch_table.each do |row|
      merch_hash = {}
      row_headers = row.headers
      merch_hash[row_headers[0].to_sym] = row[0]
      merch_hash[row_headers[1].to_sym] = row[1]
      merch_array.push(Merchant.new(merch_hash))
    end
    #MerchantsRepository.new(merch_array)
    merch_array
  end

end
