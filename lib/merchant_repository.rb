require 'csv'

class MerchantRepository
attr_accessor :file

  def initialize

  end

  def load_data(file)
    CSV.open "#{file}", headers: true, header_converters:
:symbol

  end

  def all

  end

  def find_by_id

  end

  def find_by_name

  end



end
