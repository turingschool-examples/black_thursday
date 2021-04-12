require 'csv'

class SalesEngine

  def self.from_csv(csv_files)
    merchants = []
    csv_files.each do |key, value|
      klass = Object.const_get(key.to_s.capitalize)
      p klass.new({id: '1', name: 'Zach'})
      CSV.foreach(value, headers: true,header_converters: :symbol) do |row|
        p Merchant.new(row.to_hash)
        require 'pry'; binding.pry
      end
    end
  end
end