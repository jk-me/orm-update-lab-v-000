require_relative "../config/environment.rb"

class Student
  attr_accessor :id, :name, :grade 

  def initialize(id = nil, name, grade) 
    @name = name
    @grade = grade 
    @id = id 
  end 

  def self.create_table
    sql = <<-pie 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER) 
      pie
    DB[:conn].execute(sql)
  end 
     
  
    
      

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]


end
