# frozen_string_literal: true

require 'CSV'
# Merchant Repository Class
class MerchantRepository
  attr_reader :contents,
              :parent

  def initialize(file_path, parent = nil)
    @contents = []
    @parent = parent
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @contents << Merchant.new(row, self)
    end
  end

  def all
    @contents
  end

  def find_by_id(id)
    @contents.find do |row|
      row.id == id
    end
  end

  def find_by_name(name)
    @contents.find do |row|
      row.name == name
    end
  end

  def find_all_by_name(name)
    @contet.find_all do |row|
      row.downcase == name.downcase
    end
  end
end

#
# def create(attributes)
# end
#
# def update(id, attributes)
# end
#
# def delete(id)
# end
