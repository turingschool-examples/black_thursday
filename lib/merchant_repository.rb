# This is the MerchantRepository Class
# frozen_string_literal: true.
require_relative 'merchant'

class MerchantRepository

  attr_reader :repository

  def initialize
    @repository = []
  end

  def create(data)
    data[:id] ||= 1 if repository == []
    data[:id] ||= (@repository.last.id.to_i + 1).to_s
    @repository << Merchant.new(data)
  end

  def all
    @repository
  end

  def find_by_id(id)
    repository.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    repository.find { |merchant| merchant.name.casecmp?(name) }
  end

  def find_all_by_name(name)
    repository.select { |merchant| merchant.name.downcase.include? name.downcase }
  end

  def update(id, name)
    merchant = find_by_id(id)
    merchant.update(name)
  end

  def delete(id)
    @repository.delete(find_by_id(id))
  end
end
