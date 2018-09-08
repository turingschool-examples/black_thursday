require 'CSV'
require 'pry'
module Black_Thursday_Helper

  def populate(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @merchants << Merchant.new(data)
    end
  end

end
