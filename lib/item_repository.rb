# frozen_string_literal: true

require_relative './repository'
require 'pry'
require 'bigdecimal'
require 'time'
require_relative 'item'
# stores items and gives methods for item search
class ItemRepository
  include Repository
  attr_reader :repository

  def initialize(items)
    create_repository(items, Item)
  end

  def create(attributes)
    general_create(attributes, Item)
  end
end
