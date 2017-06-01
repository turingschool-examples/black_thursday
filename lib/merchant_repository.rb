require_relative 'merchant'
require 'csv'

class MerchantRepository

  attr_reader :file_path,
              :contents

  def initialize(file_path, parent)
    @file_path = file_path
    @parent = parent
    @contents = nil
  end

  def csv_read
    CSV.read(file_path)
  end

  def organize
    header = csv_read[0]
    content = csv_read[1..-1]
    temp = []
    content.each do |line|
      item = header.zip(line).flatten.compact
      temp << item
    end
    final = []
    temp.map do |i|
      h = Hash[*i]
      final << h
    end
    @contents = final
  end

  def all
    list = []
    @contents.each do |merchant|
      m = Merchant.new(merchant,self)
      list << m
    end
    list
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
