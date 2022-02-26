require 'csv'
require './lib/merchant'
require './lib/repository_aide'

class MerchantsRepository
  include RepositoryAide
  attr_reader :repository, :ids

  def initialize(file)
    # @merchants = CSV.read(file, headers: true, header_converters: :symbol)
    @repository = read_csv(file).map do |merchant|
                  Merchant.new({:id => merchant[:id], :name => merchant[:name]})
                end
    groups
  end

  def find_by_name(name)
    find_all_by_name(name).first
  end

  def groups
    @ids = @repository.group_by {|merchant| merchant.id}
  end

  def find_all_by_name(name)
    @repository.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    merchant = Merchant.new({id: new_id.to_s, name: attributes})
    @repository << merchant
    merchant
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    merchant.name = attributes[:name]
  end

end
