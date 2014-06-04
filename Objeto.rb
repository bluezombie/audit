class Objeto
  attr_accessor :nombre, :contenido, :size

  def initialize(nombre, size, modificable)
    @nombre=nombre
    @directorio=false
    @contenido=""
    @size=size
    @modificable=modificable
  end

  def esDirectorio
    @directorio=true
  end

  def esDirectorio?
    return @directorio
  end 

  def modificable?
    @modificable
  end

end
