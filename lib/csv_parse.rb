require 'pry'
require 'csv'

class CSVParse

  def self.create_repo(path)
    csv = parse(path)
    headers, *data = csv
    repo = hashed_rows(data, headers)
    return repo
  end


  def self.parse(path)  # CEO method
    csv = CSV.read(path)
  end


  def self.hashed_rows(csv, headers)
    temp = template_hash(headers)
    hash = {}
    csv.each { |row|
      key = row[0].to_sym
      hash[key] = fill_row(row, temp.dup)
    }
    return hash
  end


  def self.fill_row(row, template)
    head, *tail = row   # head is ID, do not need
    keys = template.keys
    tail.each.with_index { |col, index|
      key = keys[index]
      template[key] = tail[index]
    }
    return template
  end


  def self.template_hash(headers)
    headers.shift   # headers mutated
    hash = {}
    headers.each { |col|
      key = col.to_sym
      hash[key] = ""
    }
    return hash
  end
end
