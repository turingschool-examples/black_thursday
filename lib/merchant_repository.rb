# frozen_string_literal: true

require 'CSV'
# Merchant Repository Class
class MerchantRepository
  attr_reader :contents,
              :parent,
              :items

  def initialize(path, parent = nil)
    @contents = []
    @parent = parent
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @contents << Merchant.new(row, self)
    end
  end

  def all
    @contents
  end

  def find_by_id(id)
    @contents.map do |row|
      row.id == @contents[0].id
      # binding.pry
    end
    @contents[0].id
  end
end

# def all
#   load_children
# end

# def find_by_name(name)
# end
#
# def find_all_by_name(name)
# end
#
# def create(attributes)
# end
#
# def update(id, attributes)
# end
#
# def delete(id)
# end
