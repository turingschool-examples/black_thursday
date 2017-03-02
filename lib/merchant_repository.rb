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
        :name => row[:name],
        :created_at => (row[:created_at])
        }, self)
        @all << merchant
      end
  end
end
