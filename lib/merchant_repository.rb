require 'csv'
require 'date'
require_relative 'merchant'
require_relative 'sales_module'

class MerchantRepository
  attr_reader :all
  def initialize(csv)
    @all = Merchant.read_file(csv)
  end

  def create(name)
    new_merchant = Merchant.new({
      id: (@all[-1].id.to_i + 1).to_s,
      name: name,
      created_at: Date.today.to_s,
      updated_at: Date.today.to_s})
      @all << new_merchant
  end

  def update(id, name)
    updated_merchant = @all.find{|merchant| merchant.id == id}
    updated_merchant.name = name
    updated_merchant.updated_at = Date.today.to_s
  end

  include SalesModule

  # def all
  #   @all
  # end
  #
  # def find_by_id(id)
  #   @all.find{|individual| individual.id == id}
  # end
  #
  # def find_by_name(name)
  #   @all.find{|individual| individual.name == name}
  # end
  #
  # def find_all_by_name(name)
  #   found = []
  #   found << @all.find_all{|individual| individual.name.downcase == name.downcase}
  #   found.flatten
  # end
  #
  # def delete(id)
  #   @all.delete(find_by_id(id))
  # end
end
