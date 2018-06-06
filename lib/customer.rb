# frozen_string_literal: false

require 'time'
# Responsible for creating Customer objects
class Customer
  attr_reader   :id,
                :created_at
  attr_accessor :first_name,
                :last_name,
                :updated_at

  def initialize(args)
    @id          = args[:id].to_i
    @first_name  = args[:first_name]
    @last_name   = args[:last_name]
    @created_at  = Time.parse(args[:created_at])
    @updated_at  = Time.parse(args[:updated_at])
  end
end
