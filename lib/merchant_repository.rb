require 'CSV'

class MerchantRepository
  attr_reader :contents,
              :parent

  def initialize(path, parent)
    @contents = {}
    @parent = parent
    load_path(path)
  end

  def load_path(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @contents[row[:id]] = Merchant.new(row, self)
    end
  end

  def all
    @contents.values
  end

  def find_by_id(id)
    @contents[id]
  end

  def find_by_name(name)
    @contents.each do |_, merchant|
      # binding.pry
      return merchant if merchant.name.casecmp == name.casecmp
    end
    nil
  end

  def find_all_by_name(name)
    @contents.find_all do |row|
      row.downcase == name.downcase
    end
  end

end
