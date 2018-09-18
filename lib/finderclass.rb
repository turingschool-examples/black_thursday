# This will consist of class methods for finder functionality

require 'pry'

class FinderClass

  # if this was a module, maybe this would work
  # def find_by(method, data, repo = @all)

  def self.find_by(repo, method, data)
    repo.find {|object| object.send(method) == data }
  end # returns an object / the first object

  def self.find_all_by(repo, method, data)
    repo.find_all {|object| object.send(method) == data }
  end # returns an array of objects

  def self.find_max(repo, method)
    repo.max_by { |object| object.send(method) }
  end # returns an object (not the max value itself)

  def self.find_by_range(repo, method, range)
    list = repo.find_all { |object| range.include?(object.send(method))}
    # low = range.first
    # high = range.last
    # list = repo.find_all { |object|
    #   value = object.send(method)
    #   value >= low && value <= high
    # }; return list
    return list
  end

  def self.find_by_insensitive(repo, method, data)
    data = data.downcase
    obj = repo.find { |object|
      value = object.send(method).downcase
      value == data
    }; return obj
  end

  def self.find_all_by_insensitive(repo, method, data)
    data = data.downcase
    list = repo.find_all{ |object|
      value = object.send(method).downcase
      value == data
    }; return list
  end

  def self.find_by_fragment(repo, method, frag)
    frag = frag.downcase
    list = repo.find_all{ |object|
      value = object.send(method).downcase
      value.include?(frag)
    }; return list
  end

  # THIS ALREADY EXISTS IN SALES ANALYSTS
  def self.group_by(collection, method)
    collection.group_by { |obj| obj.send(method) }
  end

  def self.match_by_data(repo, collection, method)
    collection.map { |data|
      repo.find_all { |obj| obj.send(method) == data }
    }.flatten
  end

  def self.day_of_week(integer)
    case integer
    when 0; "Sunday"
    when 1; "Monday"
    when 2; "Tuesday"
    when 3; "Wednesday"
    when 4; "Thursday"
    when 5; "Friday"
    when 6; "Saturday"
    end
  end



end
