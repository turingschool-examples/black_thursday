require 'csv'
require_relative './sales_engine'

class Merchants
  attr_reader   :id
  attr_accessor :name,
                :created_at,
                :updated_at

  def initialize(merchants)
    @id         = merchants[:id].to_i
    @name       = merchants[:name]
    @created_at = merchants[:created_at]
    @updated_at = merchants[:updated_at]
  end
end
