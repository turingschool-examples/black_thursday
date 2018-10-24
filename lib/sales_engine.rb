class SalesEngine

  def initialize(csv_items, csv_merchants)
  end

  def self.from_csv(csv_data_source)
    items = CSV.read(csv_data_source[:items], headers: true, header_converters: :symbol)
    merchants = CSV.read(csv_data_source[:merchants], headers: true, header_converters: :symbol)
    self.new(items, merchants)
  end

end
