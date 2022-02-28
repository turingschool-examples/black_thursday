require 'csv'
require_relative '../lib/merchant'
require_relative '../lib/repository_aide'

class MerchantsRepository
  include RepositoryAide
  attr_reader :repository, :ids

  def initialize(file)
    @repository = read_csv(file).map do |merchant|
                  Merchant.new({:id => merchant[:id], :name => merchant[:name]})
                end
    group_hash
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def group_hash
    @ids = @repository.group_by {|merchant| merchant.id}
    @names = @repository.group_by{|merchant| merchant.name.downcase}
  end

  def find_by_name(name)
    find_all_by_name(name).first
  end

  def find_all_by_name(search_name)
    @names.select do |name, info|
      name.include?(search_name.downcase)
    end.values.flatten
  end

  def create(attributes)
    merchant = Merchant.new(create_attribute_hash(attributes))
    @repository << merchant
    merchant
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    merchant.name = attributes[:name]
  end
end
