# frozen_string_literal: true

require 'csv'
require_relative './merchant_repository'
require_relative './item_repository'
require_relative './sales_analyst'

class SalesEngine
  def self.from_csv(filepaths) # Hash values are file paths
    csv_data = {}
    filepaths.each do |repo, filepath|
      csv_data[repo] = CSV.open(filepath, headers: true, header_converters: :symbol)
    end
    new(csv_data)
  end

  def initialize(data)
    @data = data
  end

  def merchants
    @merchants ||= MerchantRepository.new.tap do |merchant_repo|
      merchant_repo.populate(@data[:merchants])
    end
  end

  def items
    @items ||= ItemRepository.new.tap do |item_repo|
      item_repo.populate(@data[:items])
    end
  end

  def analyst
    SalesAnalyst.new(self)
  end
end
