class InvoiceRepository
  include Methodable

  def initialize(file_path)
    @file_path = file_path
  end
end
