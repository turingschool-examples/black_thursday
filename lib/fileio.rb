require 'csv'

# file io class
class FileIO
  def self.load(path)
    CSV.read path
  end
end

=begin
def self.load(path)
  contents = CSV.open path, headers: true
  contents.each do |row|
    id = row['id']
    name = row['name']
    @id << id
    @name << name
  end
end
=end
