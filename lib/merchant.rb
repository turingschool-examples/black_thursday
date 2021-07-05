# frozen_string_literal: false

require 'time'
# Responsible for creating Merchant objects
class Merchant
  attr_reader   :id,
                :created_at
  attr_accessor :name,
                :updated_at

  def initialize(args)
    @id         = args[:id].to_i
    @name       = args[:name]
    @created_at = args[:created_at]
    @updated_at = args[:updated_at]
  end
end
