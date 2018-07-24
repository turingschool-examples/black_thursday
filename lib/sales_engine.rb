# frozen_string_literal: true

require 'csv'
require './lib/merchant_repository'
require './lib/item_repository'

class SalesEngine
  attr_reader :items

  def self.from_csv(filepaths) # Hash values are file paths
    new(filepaths)
  end

  def initialize(filepaths)
    @filepaths = filepaths
  end

  def merchants
    @merchants ||= MerchantRepository.new.tap do |merchant_repo|
      merchant_repo.populate_from_csv(@filepaths[:merchants])
    end
  end
end
