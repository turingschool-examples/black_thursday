# frozen_string_literal: true
class Merchant
  attr_reader :id,
              :created_at
  attr_accessor :name

  def initialize(info)
    @id           = info[:id].to_i
    @name         = info[:name]
    @created_at   = Time.parse(info[:created_at])
    @updated_at   = Time.parse(info[:updated_at])
  end

  def change_name(name)
    @name = name
  end
end
