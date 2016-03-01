require 'csv'
require 'pry'
class SalesEngine
  attr_reader :csv_content
  def initialize
    @csv_content = {}
  end

  def from_csv(hash)
     hash.each do |key, value|
      @csv_content[key] = CSV.read(value, headers: true, header_converters: :symbol)
    end
  end

  def merchants
    MerchantRepository.new(@csv_content[:merchants])
  end

end
# pry(#<SalesEngine>)> @csv_content[:merchants]
# => #<CSV::Table mode:col_or_row row_count:4>
# [2] pry(#<SalesEngine>)> @csv_content[:merchants][:id]
# => ["12334105", "12334112", "12334113"]
# [3] pry(#<SalesEngine>)> @csv_content[:merchants].class
# => CSV::Table
# [4] pry(#<SalesEngine>)> @csv_content.class
# => Hash
