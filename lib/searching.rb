require 'csv'

# Module of search methods
module Searching
  def data
    CSV.open(@file_path, headers: true, header_converters: :symbol)
  end

  def find_by_id(id)
    @all.find { |obj| obj.id == id }
  end

  def find_by_name(name)
    @all.find { |obj| obj.name.casecmp(name).zero? }
  end

  def find_all_by_merchant_id(id)
    @all.find_all { |obj| obj.merchant_id == id }
  end
end
