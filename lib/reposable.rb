module Reposable
  def class_name
    Object.const_get(self.class.name.chomp('Repository'))
  end

  def create(attributes)
    all << class_name.new(attributes)
  end
  
  def find_by_id(id)
    all.find do |entry|
      entry.id == id
    end
  end


#   def update(id,attributes)
#     attributes.each do |attr,val|
#       find_by_id
# require 'pry'; binding.pry
#     end
  
end