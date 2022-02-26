require 'time'

class Merchant

  attr_accessor :name, :updated_at
  attr_reader :created_at, :id

  def initialize(info)
    @id = info[:id].to_i
    @name = info[:name]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
  end


end
