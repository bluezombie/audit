class Objeto
  attr_accessor :nombre, :contenido

  def initialize(nombre)
    @nombre=nombre
    @directorio=false
    @contenido=""
  end

  def esDirectorio
    @directorio=true
  end

  def esDirectorio?
    return @directorio
  end 
end
