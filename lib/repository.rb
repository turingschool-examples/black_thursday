
class Repository

  attr_reader :repo_array

  def initialize(csv_filepath)
    @repo_array  = []
    create_repo_array(csv_filepath)
  end

  def create_repo_array(csv_filepath)
    row_objects = CSV.read(csv_filepath, headers: true, header_converters: :symbol)
      @repo_array = row_objects.map do |row|
        new_record(row)
      end
  end

  def all
    @repo_array
  end

  def find_by_id(id)
    @repo_array.find do |object|
      object.id == id
    end
  end

  def new_highest_id
    all.max_by do |object|
      object.id
    end.id + 1
  end

  def delete(id)
    index = @repo_array.find_index do |object|
      object.id == id
    end
    return nil if index == nil
    @repo_array.delete_at(index)
  end


  

  def inspect
    "#<#{self.class} #{@repo_array.size} rows>"
  end

end
