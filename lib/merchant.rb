require 'csv'
require './lib/merchant_repo'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :parent

  def initialize(data)
      # @parent = repo
      @id = data[:id].to_i
      @name = data[:name].to_s
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
  end
end


