# frozen_string_literal: true

require 'time'

# ./lib/merchant.rb
class Merchant
  attr_reader :id,
              :created_at
  attr_accessor :name

  @@highest_merchant_id = 0

  def initialize(hash)
    @id = hash[:id].to_i
    @name = hash[:name]
    @created_at = created_date(hash[:created_at])
    highest_id_updater
  end

  def highest_id_updater
    @@highest_merchant_id = @id if @id > @@highest_merchant_id
  end

  def created_date(time)
    if time.class == String
      fixed_time = Time.parse(time)
    else
      fixed_time = Time.parse("01-01-1900")
    end
    fixed_time
  end

  def self.create(name)
    merchant_id = @@highest_merchant_id += 1
    Merchant.new(id: merchant_id,
                 name: name[:name])
  end
end
