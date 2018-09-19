require_relative "../config/environment.rb"

class Student
  attr_accessor :id, :name, :grade

  def initialize(id = nil, name, grade)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER)
        SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute('drop table if exists students')
  end 

  def save 
    sql = <<-sql 
      INSERT INTO students (name, grade)
      VALUES (?,?)
      sql
    DB[:conn].execute(sql,self.name, self.grade)
    @id = DB[:conn].execute('select last_insert_rowid() from students')
  end 

  def self.create (:name, :grade)
    student = self.new(name,grade)
    student.save 
    student 
  end 

  def self.new_from_db(row) 
    id = row[0]
    name = row[1]
    grade = row[2]
    self.new(id,name,grade)
  end 

  def self.find_by_name(name)
    sql = <<-sql 
      select * from students where name = ? 
      sql
    self.new_from_db(DB[:conn].execute(sql,name) )
  end 


  
  




  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]


end
