module RepositoryHelper
  def populate(data)
    data.map do |row|
      create(row)
    end
  end
end
