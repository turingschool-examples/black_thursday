require "pry"
require "time"

class Merchant

  attr_reader :name,
              :id,
              :created_at,
              :updated_at,
              :parent

  def initialize(merchant_data, parent)
              @name       = merchant_data[:name].to_s
              @id         = merchant_data[:id].to_i
              @created_at = Time.parse(merchant_data[:created_at])
              @updated_at = Time.parse(merchant_data[:updated_at])
              @parent     = parent
  end
end
