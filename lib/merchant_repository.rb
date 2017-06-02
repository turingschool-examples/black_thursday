require_relative 'merchant'
require 'csv'
require 'pry'
class MerchantRepository

  attr_reader :file_path,
              :contents

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
      library[d] = Merchant.new(h, self)
    end
    @contents = library
  end

  def all
    merchants = contents.map { |k,v| v }
  end

  def find_by_id(id_number)
    #think about cleaning this up a little
    number = @contents.keys.find { |k| k == id_number }
    if number == nil
      return number
    else
      @contents[id_number].id
    end
  end

  def find_by_name(merchant)
    m = @contents.find { |k,v| contents[k].name.downcase == merchant.downcase }
    if m == nil
      return m
    else
      m[1].name
    end
  end

  def find_all_by_name(merchant)
    all = []
    lookup = @contents.find_all { |k,v| contents[k].name.include?(merchant.downcase) }
    lookup.compact
  end

end
