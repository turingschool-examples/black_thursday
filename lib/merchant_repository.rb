require 'helper'
require './lib/repository_methods_module'

class MerchantRepository
  include RepositoryMethods
  attr_reader :all

  def initialize(file_path)
    @all = make_repo(file_path)
  end

  def find_all_by_name(input)
    @all.select {|merchant| merchant.name.downcase.include?(input.downcase.strip)}
  end

  def create(name)
    @all.push(Merchant.new({
      :id => max_id + 1,
      :name => name
      }))
  end

  def update(id,new_name)
    to_be_updated = find_by_id(id)
    to_be_updated.name = new_name
  end

end
