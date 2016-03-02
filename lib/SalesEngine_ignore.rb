require 'csv'
class SalesEngine
  def self.from_csv(data_type, file_path)
    # data is drawing from a hash
  end

  # instantiation of items and merchants and invoices
end

# se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})

se = File.readlines ("../data/invoices.csv")
puts se

# Items = attr_accessor 
# ItemRepository = internal method
