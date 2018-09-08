require 'Csv'
class CsvAdapter

  def load
    items_objs = CSV.read("./data/items.csv",
    headers: true, header_converters: :symbol)
    merchant_objs = CSV.read("./data/merchants.csv",
    headers: true, header_converters: :symbol)
    item_merchant_hash = {
      items: items_objs,
      merchants: merchant_objs
    }
  end

end
