class InvoiceRepository
  attr_reader :all, :file_path

  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Invoice.new({
        :id          => [:id],
        :customer_id => [:customer_id],
        :merchant_id => [:merchant_id],
        :status      => [:status],
        :created_at  => Time.now,
        :updated_at  => Time.now
        })
    end
  end
end
