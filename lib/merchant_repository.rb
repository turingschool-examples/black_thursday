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

  end

  def find_by_id(id_number)
    m = nil
    @contents.each do |merchant|
      mt = Merchant.new(merchant,self)
      m = mt if mt.id == id_number
    end
    m
  end

  def find_by_name(name)
    m = nil
    @contents.each do |merchant|
      mt = Merchant.new(merchant,self)
      m = mt if mt.name.downcase == name.downcase
    end
    m
  end

  def find_all_by_name(name)
    m = []
    @contents.each do |merchant|
      mt = Merchant.new(merchant,self)
      if mt.name.downcase.include?(name)
        match = mt
        m << match
      end
    end
    m
  end

end
