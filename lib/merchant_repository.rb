
class MerchantRepository
  attr_reader :merchant_list
  def initialize(file_path)
    @merchant_list = {}
    CSV.foreach(file_path, headers: true) do |row|
      @merchant_list[row[0]] = 

      # id: row['id'].to_i
      # name: row['name']
    end

  end

  def all
    # returns array of all known merchant instances
  end

  def find_by_id
    # returns either nil or an instance of Merchant
    #matching ID
  end

  def find_by_name
    # returns either nil or and instance of Merchant having
    # done case-INSENSITIVE search
  end

  def find_all_by_name
    # returns either [] or one or more matches which contain the
    # supplied name fragment, case INSENSITIVE
  end
end
