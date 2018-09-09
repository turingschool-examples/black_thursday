class DataRepository
  # TODO: Create tests for populate & sublass instantiation
  def populate(data, data_class)
    @data_set = data.map do |key, entry|
      [key, data_class.new(entry)]
    end.to_h
  end
end
