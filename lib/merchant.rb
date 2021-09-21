require 'csv'

class Merchant
  attr_reader   :created_at, :updated_at
  attr_accessor :name, :id


  def initialize(info)
    @id = info[:id].to_i
    @name = info[:name]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
  end
end
