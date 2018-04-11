# frozen_string_literal: true

require_relative './item_repository'
require_relative './merchant_repository'
require_relative './fileio'

class SalesEngine
  attr_reader :items,
              :merchants
  def initialize(paths)
    @items = ItemRepository.new(FileIo.load(paths[:items]))
    @merchants = MerchantRepository.new(FileIo.load(paths[:merchants]))
  end

  def self.from_csv(path)
    SalesEngine.new(path)
  end
end