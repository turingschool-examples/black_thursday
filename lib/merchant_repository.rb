require 'CSV'
require_relative 'merchant'

class MerchantRepository
  attr_reader :all

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new(
        :id => row[:id].to_i,
        :name => row[:name]
        )
      end
  end

  def find_by_id(id)
    @all.find {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    @all.find {|merchant| merchant.name.upcase == name.upcase}
  end

  def find_all_by_name(name_fragment)
    @all.find_all {|merchant| merchant.name.upcase.include?(name_fragment.upcase)}
  end

  def create(attributes)
    x = (@all.last.id + 1)
    binding.pry
    @all << Merchant.new({
      :id => x,
      :name => attributes[:name]
      })
  end

  def update(id, attributes)
    x = find_by_id(id)
    x.name = attributes[:name]
  end

  def delete(id)
    x = find_by_id(id)
    @all.delete(x)
  end

end
