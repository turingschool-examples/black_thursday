module RepoQueries

  def all
    @data
  end

  def find_by_id(id)
    all.find do |data|
      data.id == id
    end
  end    

  # def find_by_name(name)
  #   all.find do |merchant|
  #     name.casecmp?(merchant.name)
  #   end
  # end

end