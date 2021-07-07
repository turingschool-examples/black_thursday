require_relative 'merchant'
require_relative 'repo_helper'
require 'pry'

class MerchantRepository
  include RepoHelper
  attr_reader :repo

  def initialize(csv_file)
    @repo = csv_file.map do |merchant|
      Merchant.new(merchant)
    end
  end

  def find_all_by_name(name)
    all_names = @repo.select do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
    return all_names
  end

  def create(attributes)
    max_id = @repo.max_by do |merchant|
      merchant.id
    end # this returns the complete merchant object with highest id
    new_id = max_id.id + 1
    new_merchant = Merchant.new(
      id: new_id,    #check for .to_s later
      name: attributes[:name],
      created_at: Time.now,
      updated_at: Time.now
    )
    @repo << new_merchant
    new_merchant
  end

  def update(id, attributes)
    new_name = attributes[:name]
    merchant = find_by_id(id)
    return if merchant.nil?
    merchant.updated_at = Time.now
    merchant.name = new_name
    merchant
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
