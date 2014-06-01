class Objeto
  attr_accessor :nombre, :contenido, :size

  def initialize(nombre, size)
    @nombre=nombre
    @directorio=false
    @contenido=""
    @size=size
  end

  def esDirectorio
    @directorio=true
  end

  def esDirectorio?
    return @directorio
  end 

end
