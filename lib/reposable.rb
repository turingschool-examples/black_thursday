module Reposable
  def class_name
    Object.const_get(self.class.name.chomp('Repository'))
  end

  def create(attributes)
    all << class_name.new(attributes)
  end
end