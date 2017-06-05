require_relative 'merchant'
require 'csv'
require 'pry'
class MerchantRepository

  attr_reader :file_path,
              :contents,
              :parent

  def initialize(file_path, parent)
    @file_path = file_path
    @parent = parent
    @contents = load_library
  end

  def load_library
    library = {}
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      h = Hash[row]
      d = h[:id]
      library[d.to_i] = Merchant.new(h, self)
    end
    @contents = library
  end

  def all
    merchants = contents.map { |k,v| v }
  end

  def find_by_id(id_number)
    number = @contents.keys.find { |k| k == id_number }
    contents[number]
  end

  def find_by_name(merchant)
    m = @contents.find { |k,v| contents[k].name.downcase == merchant.downcase }
    if m == nil
      return m
    else
      contents[m[0]]
    end
  end

  def find_all_by_name(merchant)
    lookup = contents.values.find_all { |v| v.name.downcase.include?(merchant.downcase) }
    lookup.compact
  end

  def inspect
    "#<#{self.class} #{@contents.size} rows>"
  end

end
