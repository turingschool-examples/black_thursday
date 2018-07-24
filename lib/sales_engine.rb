# frozen_string_literal: true

require 'csv'
require_relative './merchant_repository'
require_relative './item_repository'

class SalesEngine
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

  def items
    @items ||= ItemRepository.new.tap do |item_repo|
      item_repo.populate_from_csv(@filepaths[:items])
    end
  end
end
