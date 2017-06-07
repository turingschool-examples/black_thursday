require 'pry'
require 'csv'
require_relative 'item'
class ItemRepository
  attr_reader :file_path,
              :parent,
              :contents

  def initialize(file_path, parent)
    @file_path = file_path
    @parent = parent
    @contents = load_library
  end


  def load_library
    x = {}
    CSV.foreach(file_path, headers: true,
                :header_converters => :symbol) do |row|

      h = Hash[row]
      d = h[:id]
      # d = h.delete(:id)
      x[d.to_i] = Item.new(h, self)
    end
    x
  end

  def all
    contents.map { |k,v| v }
    # final = []
    # final << contents
  end

  def find_by_id(id_number)
    contents[id_number]
  end

  def find_by_name(i_name)
    n = contents.values.find { |v| v.name.downcase == i_name.downcase }
    if n == nil
      return n
    end
    n
    # contents.each do |k,v|
    #   binding.pry
    #   if v.name == name
    #     return contents[k]
    #   else
    #     return nil
    #   end
    # end
  end

  def find_all_with_description(str)
    final = []
    contents.each do |k,v|
      if v.description.downcase.include? str.downcase
       final << contents[k]
      end
    end
    return final
  end

  def find_all_by_price(price)
    final = []
    contents.each do |k,v|
      if v.unit_price == price
        final << contents[k]
      end
    end
    return final
  end

  def find_all_by_price_in_range(price_range)
    final = []
    contents.each do |k,v|
      if price_range.include?(v.unit_price.to_f)
        final << contents[k]
      end
    end
    return final
  end

  def find_all_by_merchant_id(id_number)
    final = []
    contents.each do |k,v|
      if v.merchant_id.to_i == id_number.to_i
        final << contents[k]
      end
    end
    return final
  end

  def inspect
    "#<#{self.class} #{@contents.size} rows>"
  end

end
