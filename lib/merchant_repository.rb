require 'CSV'
require_relative 'merchant'
require 'pry'
class MerchantRepository
  attr_reader :contents,
              :parent

  def initialize(path, parent)
    @contents = []
    @parent = parent
    load_path(path)
  end

  def load_path(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
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

  def find_all_by_name()
  end

  def create(attributes)
    max_id = @contents.map(&:id).max
    max_id += 1
    attributes[:id] = max_id
    @contents << Merchant.new(attributes, self)
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    attributes.keys.each do |key|
      merchant.key = attributes[key]
    end
  end

  def inspect
    "<#{self.class} #{@contents.size} rows>"
  end
end
