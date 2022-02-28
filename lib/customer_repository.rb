class CustomerRepository
  def initialize(info)
    @all = info
  end
  def find_all_by_first_name(first_name)
    @all.find_all{|index| index.first_name == first_name}
  end
  def find_all_by_last_name(last_name)
    @all.find_all{|index| index.last_name == last_name}
  end


end 
