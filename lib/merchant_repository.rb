require 'CSV'
require_relative '../lib/merchant'
require_relative 'repoable'

class MerchantRepository
  include Repoable
  attr_accessor :file_path,
                :all

  def initialize(file_path)
    @file_path = file_path
    @all =[]
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new({:id => row[:id], :name => row[:name]})
    end
  end

  def find_all_by_name(name)
    @all.find_all {|merchant| merchant.name.downcase.include?(name.downcase)}
  end

  def create(hash)
    id = (@all.last.id.to_i + 1)
    @all << Merchant.new({:id => id, :name => hash[:name]})
  end

  def update(id, attributes)
    if find_by_id(id) != nil
      @all.find {|merchant| merchant.id == id}.name = attributes[:name]
    else
    end
  end
end
