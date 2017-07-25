class MerchantRepository

  attr_reader :file_path,
              :sales_engine

  def initialize(file_path, sales_engine)
    @sales_engine = sales_engine
    @file_path    = file_path
  end

  def load_repo
    repo = {}
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      row = Merchant.new
  end

end
