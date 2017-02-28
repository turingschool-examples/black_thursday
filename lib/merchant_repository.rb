require_relative 'merchant'
require_relative '../lib/data_access'

class MerchantRepository
  include DataAccess
  attr_reader :csv_file,
              :all,
              :parent

  def initialize(path, parent=nil)
    @csv_file = CSV.open(path, headers: true, header_converters: :symbol)
    @all = []
    @parent = parent
    populate_repo
  end

  def populate_repo
    csv_file.each do |row|
      merchant = Merchant.new({:id => row[:id].to_i,
        :name => row[:name]}, self)
        @all << merchant
        #return an array, then you can nix @all
      end
  end

#######################
  # def find_by_id(id)
  #   all.find{ |merchant| merchant.id == id }
  # end

  # def find_by_name(name)
  #   all.find{ |merchant| merchant.name.downcase == name.downcase }
  # end

  # def find_all_by_name(name_frag)
  #    all.select{ |merchant| merchant.name.downcase.include?(name_frag.downcase) }
  # end

  # def inspect
  #   "#<#{self.class} #{@merchants.size} rows>"
  # end
###########################
end
