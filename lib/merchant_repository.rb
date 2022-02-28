require_relative "module"

class MerchantRepository
  include IDManager

attr_reader :all
  def initialize(merchants)
    @all = merchants
  end

  def find_all_by_name(search)
    @all.find_all{|index| index.name.upcase.include?(search.upcase)}
  end
#inspect method is required for spec harness to run
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
