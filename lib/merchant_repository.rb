class MerchantRepository

  def initialize(filepath)
    @filepath = nil
  end


  def get_all_merchants_from_csv
    #enumerable to iterate through all CSV lines
    create_merchant_object_array
  end

  def create_merchant_object_array(csv, merchant_array = [])
      # merchant_array <<

  end

  def all
    get_all_merchants_from_csv

  end

  def find_by_id
    get_merchants_by_id
  end


  def get_merchants_by_id
    #do the things
    create_merchant_object_array
  end

  def get_merchants_by_name
    #do the things
    create_merchant_object_array

  end
end
