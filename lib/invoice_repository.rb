require_relative './repo_module'
require_relative './invoice'

class InvoiceRepository
  include RepoModule

  attr_reader :all

  def initialize(file_path)
    @class_name = Invoice
    @all = from_csv(file_path)
  end
end
