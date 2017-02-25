require 'csv'
# require_relative './invoice'

class InvoiceRepository
  attr_accessor :invoices_array
  # attr_reader :contents, :engine
  #
  def initialize(path, engine = '')
    @invoices_path = path
    @invoices_array = []
    @engine = engine
    # pull_csv
    # parse_csv
  end
  #
  # def pull_csv
  #   @contents = CSV.open @merchants_path, headers: true, header_converters: :symbol
  # end
  #
  # def parse_csv
  #   @contents.each do |row|
  #     name = row[:name]
  #     id = row[:id]
  #     merchants_array << Merchant.new({:id => id.to_i, :name => name}, self)
  #   end
  # end
  #
  # def all
  #   merchants_array
  # end
  #
  # def find_by_id(find_id)
  #   merchants_array.find do |instance|
  #     instance.id == find_id
  #   end
  # end
  #
  # def find_by_name(find_name)
  #   merchants_array.find do |instance|
  #     instance.name.downcase == find_name.downcase
  #   end
  # end
  #
  # def find_all_by_name(find_fragment)
  #   merchants_array.find_all do |instance|
  #     instance.name.downcase.include?(find_fragment.downcase)
  #   end
  # end
  #
  # def inspect
  #   "#<#{self.class} #{@merchants.size} rows>"
  # end
end
