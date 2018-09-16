require 'CSV'
require 'pry'
require 'time'
require 'bigdecimal'
require_relative '../lib/black_thursday_helper'

class InvoiceRepository
  include BlackThursdayHelper

  def initialize(file_path)
    @collections = []
    populate(file_path)
  end

  def populate(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @collections << Invoice.new(data)
    end
  end

end
