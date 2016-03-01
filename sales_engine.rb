require 'csv'
require 'pry'
class SalesEngine

  def from_csv(hash)

    @csv_content = {}
     hash.each do |key, value|
      @csv_content[key] = CSV.read(value, headers: true, header_converters: :symbol)
    end
    binding.pry
  end

  def merchants
    MerchantRepository.new(@csv_contents[:merchants])
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
