require_relative 'merchant.rb'
require_relative 'repository_helper.rb'
require 'pry'

class MerchantRepository
  include RepositoryHelper
  attr_reader :merchants, :repository

  def initialize(file_contents)
    @repository = file_contents.map { |merchant| Merchant.new(merchant) }
  end

  def find_all_by_name(name)
    @repository.select do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    max_id = @repository.sort_by{ |merchant| merchant.id }.last.id
    new_id = max_id + 1
    new_merchant = Merchant.new({
                    id: new_id.to_s,
                    name: attributes[:name],
                    created_at: Time.now,
                    updated_at: Time.now
                    })
    @repository << new_merchant
    new_merchant
  end

  def update(id, attributes)
    new_name = attributes[:name]
    merchant = find_by_id(id)
    if !merchant.nil?
      merchant.updated_at = Time.now
      merchant.name = new_name
      merchant
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
