require 'csv'

require_relative '../lib/merchant'
require_relative '../lib/repository_helper'

class MerchantRepository
  include RepositoryHelper

  attr_reader     :filepath,
                  :all
  def initialize(filepath)
    @filepath = filepath
    @all = []
  end

  def create_all_from_csv(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new(row)
    end
  end

  def create(attributes)
    id = find_highest_id.id + 1
    merchant = Merchant.new(
      id: id,
      name: attributes[:name],
      created_at: Time.now,
      updated_at: Time.now,
      )
    @all << merchant
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    return if merchant.nil?
    merchant.name = attributes[:name] || merchant.name
    merchant.updated_at = Time.now
    merchant
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
