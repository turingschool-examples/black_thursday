module RepositoryMethods

  def find_by_id(id_number)
    self.all.find {|element| element.id == id_number}
  end

  def find_by_name(name)
    self.all.find {|element| element.name.downcase == name.downcase.strip}
  end

  def max_id
    (self.all.max_by {|element| element.id}).id
  end

  def delete(id)
    to_be_dropped = find_by_id(id)
    self.all.delete(to_be_dropped)
    self.find_by_id(id) == nil ? 'Deletion complete!' : '...something went wrong'
  end

  def make_repo(file_path)
    repo = Array.new
    class_name = self.class.to_s.chomp("Repository")
    repo_contents_name = Object.const_get(class_name)

    CSV.foreach(file_path, headers: true, header_converters: :symbol){|row| repo.push(repo_contents_name.new(row))}

    repo
  end

end
