require './lib/merchant'
require 'csv'
require './lib/merchant'

class MerchantRepository
  attr_reader :all,
              :csv

  def initialize(path)
    csv_load(path)
  end

  def csv_load(path)
    @csv = CSV.open path, headers: true, header_converters: :symbol
  end

  def all
    all = []
    @csv.each do |line|
      all << [line[:id].to_i, line[:name]]
    end
    return all
  end

  def find_by_id(id)
    return nil if id.nil?
    all.include?[id]
  end
  #
  # def find_by_name(name)
  #   return nil if name.nil?
  #   # return either nil or instance of merchant having done a case insensitive search
  # end
  #
  # def find_all_by_name(names)
  #   # returns either [] or one or more matches that contain the supplied name fragment, case insensitive
  # end
end
