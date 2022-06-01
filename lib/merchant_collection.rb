require 'CSV'
require './lib/merchant'
class MerchantCollection

  attr_reader :all
  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new(:id => row[:id], :name => row[:name])
    end
  end

  def find_by_id(id)
    @all.find {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    @all.find {|merchant| merchant.name == name}
  end

  def find_all_by_name(name)
    @all.find_all {|merchant| merchant.name.upcase.include?(name.upcase)}
  end

  def create(attributes)
    max_id = @all.max_by {|merchant| merchant.id}
    attributes[:id] = (max_id.id.to_i + 1).to_s
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    new = Merchant.new(attributes)
    @all.push(new)
  end

end
