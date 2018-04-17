module CustomerHelper
  def find_all_by_first_name(name)
    @repository.values.find_all do |customer|
      customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    @repository.values.find_all do |customer|
      customer.last_name.downcase.include?(name.downcase)
    end
  end
end
