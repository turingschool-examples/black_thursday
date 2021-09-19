# frozen_string_literal: true

require 'csv'
require_relative './sales_engine'

class Merchant
  attr_reader   :id
  attr_accessor :name,
                :created_at,
                :updated_at

  def initialize(merchants)
    @id         = merchants[0].to_i
    @name       = merchants[1]
    @created_at = merchants[2]
    @updated_at = merchants[3]
  end
end
