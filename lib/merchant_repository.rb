require 'CSV'
require_relative 'repo_module'

class MerchantRepository
  include RepoModule
  attr_reader :repo

  def initialize(file_path)
    @repo = []
    load_merchants(file_path)
  end

  def load_merchants(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @repo << Merchant.new(row)
    end
  end

  def find_all_by_name(name)
    @repo.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    attributes[:id] = @repo[-1].id + 1
    @repo << Merchant.new(attributes)
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    merchant.name = attributes[:name] unless attributes[:name].nil?
  end

end
