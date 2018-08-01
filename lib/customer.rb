# frozen_string_literal: true

require 'bigdecimal'
require 'time'

# ./lib/customer.rb
class Customer
  attr_reader   :id,
                :created_at

  attr_accessor :first_name,
                :last_name,
                :updated_at

  @@highest_item_id = 0

  def initialize(attributes)
    @id = attributes[:id].to_i
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @created_at = Time.parse(attributes[:created_at])
    @updated_at = Time.parse(attributes[:updated_at])
    highest_id_updater
  end

  def highest_id_updater
    @@highest_item_id = @id if @id > @@highest_item_id
  end

  def self.create(attributes)
    item_id = @@highest_item_id += 1
    new(id: item_id,
        first_name: attributes[:first_name],
        last_name: attributes[:last_name],
        created_at: attributes[:created_at].to_s,
        updated_at: attributes[:updated_at].to_s)
  end
end
