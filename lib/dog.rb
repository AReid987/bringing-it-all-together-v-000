class Dog

  attr_accessor :id, :name, :breed

  def initialize(params)
    params.each do |k, v|
      self.send("#{k}=", v)
    end
  end

  def insert
    sql = <<-SQL
      INSERT INTO dogs (name, breed) VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.breed)
  end

  def update

  end

  def save
    self.insert
    sql = <<-SQL
      SELECT * FROM dogs WHERE name = ?
    SQL

    row = DB[:conn].execute(sql, self.name)
    self.id = row[0][0]
    self
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE if NOT EXIST dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
      )
    SQL
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE if EXISTS dogs
    SQL
    DB[:conn].execute(sql)
  end

  def self.create(row)
    dog = self.new(row)
    dog.save
    #binding.pry
  end

  def self.find_by_id(id)
    sql = <<-SQL
      SELECT * FROM dogs WHERE id = ?
    SQL

    row = DB[:conn].execute(sql, id).flatten
    attributes = {id: row[0], name: row[1], breed: row[2]}
    dog = self.create(attributes)
  end

  def self.find_or_create_by(params)
    sql = <<-SQL
      SELECT * FROM dogs WHERE name = ?, breed = ?
    SQL

    row = DB[:conn].execute(sql)
      end
    end

    #dog = find_by_id(row[0])
  end

end
