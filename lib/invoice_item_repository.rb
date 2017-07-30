class InvoiceItemRepository

  def initialize(file_path, sales_engine)
    @file_path    = file_path
    @sales_engine = sales_engine
    id_repo       = {}
  end

end
