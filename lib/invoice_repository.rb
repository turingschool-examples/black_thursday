require 'helper'

class InvoiceRepository
  attr_reader :all

  def initialize(file_path)
    @all = make_repo(file_path)
  end

  def make_repo(file_path)
    repo = Array.new
    CSV.foreach(file_path, headers: true, header_converters: :symbol){|row| repo.push(Invoice.new(row))}
    repo
  end

  def find_by_id(id_number)
    @all.find {|invoice| invoice.id == id_number}
  end

  def find_by_customer_id(id_number)
    @all.find {|invoice| invoice.customer_id == id_number}
  end
end
