# require 'CSV'
require 'pry'
require_relative './sales_engine.rb'
require_relative './findable.rb'
require_relative './invoice_item.rb'
require_relative './crudable.rb'
require 'BigDecimal'
# require 'simplecov'
# SimpleCov.start


  include Findable
  include Crudable
  attr_reader :all
  attr_accessor :new_object

  def initialize array
    @all = array
    @new_object = InvoiceItem
  end

  def inspect
  end
