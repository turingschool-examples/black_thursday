require_relative 'merchant'

class MerchantRepository
  attr_reader :csv_file, :all
  
  def initialize(path)
    @csv_file = CSV.open(path, headers: true, header_converters: :symbol)
    @all = []
    make_merchants
  end

  def make_merchants
    csv_file.each do |row|
      merchant = Merchant.new({:id => row[:id].to_i,
        :name => row[:name]})
        @all << merchant
        #return an array, then you can nix @all
      end
  end

  def find_by_id(id)
    all.find{ |merchant| merchant.id == id }
  end

  def find_by_name(name)
    all.find{ |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name_frag)
     all.select{ |merchant| merchant.name.downcase.include?(name_frag.downcase) }
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end

