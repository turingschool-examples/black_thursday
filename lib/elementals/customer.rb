require 'time'
require_relative 'elementals'

# customer class
class Customer
  include Elementals
  attr_reader :id,
              :created_at

  attr_accessor :first_name,
                :last_name,
                :updated_at

  def initialize(attrs)
    @id = attrs[:id].to_i
    @first_name = attrs[:first_name]
    @last_name = attrs[:last_name]
    @created_at  = format_time(attrs[:created_at])
    @updated_at  = format_time(attrs[:updated_at])
  end
end
