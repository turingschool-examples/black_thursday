require_relative 'repo_methods'
require_relative 'invoice'

class InvoiceRepository
  include RepoMethods
  attr_reader :collection

  def initialize(data_from_csv)
    @collection = get_data_from_csv(data_from_csv)
  end

  def get_data_from_csv(data_from_csv)
    data_from_csv.map do |line|
      [line[:id].to_i, Invoice.new(line)]
    end.to_h
  end

  def create(attributes)
    attributes[:id] = new_id
    @collection[new_id] = Invoice.new(attributes)
  end
end
