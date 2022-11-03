# frozen_string_literal: true

require 'csv'
require_relative 'merchant_repository'

# This is the SalesEngine class
class SalesEngine
  attr_reader :repository,
              :ir_data,
              :mr_data,
              :merchants

  def initialize(ir_data, mr_data)
    @ir_data = ir_data
    @mr_data = mr_data
    @merchants = nil
    create_repositories
  end

  def create_repositories
    @merchants = MerchantRepository.new(@mr_data)
  end

  def self.from_csv(data)
    ir_data = CSV.read data[:items], headers: true, header_converters: :symbol
    mr_data = CSV.read data[:merchants], headers: true, header_converters: :symbol
    se = SalesEngine.new(ir_data, mr_data)
  end
end
