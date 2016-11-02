require 'csv'
require './lib/merchant_repo'
require 'bigdecimal'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at
              
  def initialize(data, repo)
      @parent = repo
      @id = data[:id].to_i
      @name = data[:name].to_s
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
  end
end


