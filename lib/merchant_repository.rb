require_relative 'repository'
require_relative 'merchant'
require 'date'

class MerchantRepository
  include Repository

  attr_reader :repository

  def initialize(loaded_file)
    @repository = loaded_file.map { |merchant| Merchant.new(merchant)}
  end

  def all
    @repository
  end

  def find_by_id(id)
    all.find {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    all.find {|merchant| merchant.name.downcase == name.downcase}
  end

  def find_all_by_name(fragment)
    all.find_all {|merchant| merchant.name.downcase.include?(fragment.downcase)}
  end

  def create(attributes)
    name = attributes[:name]
    highest = all.max_by {|merchant| merchant.id.to_i}
    merchant = {name: name,
                id: (highest.id + 1),
                created_at: Date.today,
                updated_at: Date.today}
    @repository.push(Merchant.new(merchant))
  end

  def update(id_num, attributes)
    merchant = find_by_id(id_num)
    return merchant if merchant == nil
    merchant.update_name(attributes[:name]) if attributes[:name] != nil
  end

end
