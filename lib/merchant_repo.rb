# frozen_string_literal: true
require 'csv'
require_relative '../lib/merchant'
require_relative '../lib/repoable'

class MerchantRepo
  include Repoable
  attr_reader :all

  def initialize(path)
    @path = path
    @all = to_array
  end

  def create_array_of_objects(things)
    things.map do | merchant |
      Merchant.new(merchant)
    end
  end

  def find_all_by_name(name)
    all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    id = find_highest_id + 1
    current_time = Time.now.strftime("%F")
    attributes = {
      id: id.to_s,
      name: attributes[:name],
      created_at: current_time,
      updated_at: current_time
    }
    @all << Merchant.new(attributes)
  end

  def update(id, attributes)
    if attributes[:name] != nil
      find_by_id(id).change_name(attributes[:name])
    end
  end
end
