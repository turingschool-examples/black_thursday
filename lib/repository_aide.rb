
module RepositoryAide

  def read_csv(file)
    CSV.read(file, headers: true, header_converters: :symbol)
  end

  def all
    @repository
  end

  def find(search_repo, match)
    search_repo[match]
  end

  def find_by_id(id)
    @repository.find do |element|
      element.id == id
    end
  end

  def new_id
    new_id = @repository.sort_by do |element|
                element.id.to_i
              end.last.id.to_i
    new_id += 1
  end

  def create_attribute_hash(attributes)
    attribute_hash = {}
    attributes.each do |key, value|
      attribute_hash[key] = value
    end
    attribute_hash[:id] = new_id
    attribute_hash[:created_at] = Time.new
    attribute_hash[:updated_at] = Time.new
    require 'pry'; binding.pry
    attribute_hash
  end

  def delete(id)
    @repository.delete(find_by_id(id))
  end
end
