module Reposable
  def class_name
    Object.const_get(self.class.name.chomp('Repository'))
  end
end