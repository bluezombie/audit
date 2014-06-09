#!/usr/bin/env ruby
require 'fusefs'
require 'Objeto.rb'

class HelloDir
  #Constructor
  def initialize
    @archivos = []
    carga_archivos #Cargo algunos archivos en el sistema
  end

  def contents(path)
    logging("contents llamado con el path #{path}")
    salida = []
    @archivos.each do |objeto|
      salida.push(objeto.nombre)
    end 
    salida
  end

  #Verifico si el path pasado en el parametro
  #corresponde con un archivo
  def file?(path)
    logging("file? llamado con el path #{path}")
    objeto=obtener(path)
    return objeto.esDirectorio
  end

  def read_file(path)
    logging("read_file llamado con el path #{path}")
    objeto=obtener(path)
    objeto.contenido
  end

  def write_to(path,str)
    logging("write_to llamado con el path #{path} y con el texto #{str}")
    objeto=obtener(path)
    objeto.contenido=str
    objeto.contenido
  end

  def raw_open(path, mode)
    logging("raw_open llamado con el path #{path} y los permisos #{mode}")
    objeto=obtener(path)
    puts objeto.Class
  end

  def raw_close(path, raw)
    logging("raw_close llamado con el path #{path}")
    raw.Class
  end

  def raw_write(path, raw)
    logging("raw_write llamado con el path #{path}")
    raw.Class
  end

  def directory?(path)
    logging("directory? llamado con el path #{path}")
    return false
  end

  def can_write?(path)
    logging("can_write? llamado con el path #{path}")
    objeto=obtener(path)
    objeto.modificable?
  end

  #Obtengo el tamanio del archivo
  def size(path)
    logging("size llamado con el path #{path}")
    objeto=obtener(path)
    objeto.size
  end
  
  #Carga de archivos en el sistema
  def carga_archivos
    archivo1=Objeto.new("hola.txt",1024,true)
    archivo1.contenido="Soy el archivo 1"
    @archivos.push(archivo1)
    archivo2=Objeto.new("sistemasoperativo.txt",2048,false)
    archivo2.contenido="Soy el archivo sistemasoperativos.txt"
    @archivos.push(archivo2)
  end

  #A partir del path pasado por la system call
  #obtengo el objeto asociado
  def obtener(path)
    analizador=path.split(/\//)
    cantidad=analizador.length
    nombre_archivo=analizador[cantidad-1]
    @archivos.each do |objeto|
      if nombre_archivo == objeto.nombre
        return objeto 
      end
    end
  end

  def logging(mensaje)
    hora = Time.now.strftime("%H:%M:%S")
    puts hora + " | " + mensaje
  end
end

hellodir = HelloDir.new
FuseFS.set_root(hellodir)

#Montamos sobre un directorio pasado
#como parametro
FuseFS.mount_under ARGV.shift
FuseFS.run
