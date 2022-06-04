require 'helper'

class MerchantRepository
  attr_reader :all

  def initialize(file_path)
    @all = make_repo(file_path)
  end

  def make_repo(file_path)
    repo = Array.new
    CSV.foreach(file_path, headers: true, header_converters: :symbol){|row| repo << Merchant.new(row)}
    repo
  end

  def find_by_id(id_number)
    @all.find {|merchant| merchant.id == id_number}
  end

  def find_by_name(name)
    @all.find {|merchant| merchant.name.downcase == name.downcase.strip}
  end

  def find_all_by_name(input)
    @all.select {|merchant| merchant.name.downcase.include?(input.downcase.strip)}
  end

  def max_id
    (@all.max_by {|merchant| merchant.id}).id
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

  def delete(id)
    to_be_dropped = find_by_id(id)
    @all.delete(to_be_dropped)
  end

end
