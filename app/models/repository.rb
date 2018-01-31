class Repository
  attr_accessor :name,
                :description
  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
  end

  def ==(repository)
    name == repository.name && description == repository.description
  end 

  
end