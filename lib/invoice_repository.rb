require 'helper'

class InvoiceRepository
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []
    require "pry"; binding.pry
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      require "pry"; binding.pry
      @all << Invoice.new(row)
    end
  end

  def find_by_id(id_number)
    @all.find {|merchant| merchant.id == id_number}
  end
end
