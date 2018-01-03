require 'pry'

class Merchant

  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent = nil)
    @id         = data[:id]
    @name       = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @parent     = parent
  end

end
