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
    salida = []
    @archivos.each do |objeto|
      salida.push(objeto.nombre)
    end 
    salida
  end

  #Verifico si el path pasado en el parametro
  #corresponde con un archivo
  def file?(path)
    objeto=obtener(path)
    return true
  end
  def read_file(path)
    "Hello, World!\n"
  end
  def directory?(path)
    return false
  end
  
  #Carga de archivos en el sistema
  def carga_archivos
    @archivos.push(Objeto.new("hola.txt"))
    @archivos.push(Objeto.new("contactos.txt"))
    #@archivos.push("/sistema")
  end

  #A partir del path pasado por la system call
  #obtengo el objeto asociado
  def obtener(path)
    puts "obtener:"
    analizador=path.split(/\//)
    cantidad=analizador.length
    nombre_archivo=analizador[cantidad-1]
    @archivos.each do |objeto|
      if nombre_archivo == objeto.nombre
        return objeto 
      end
    end
  end
end

hellodir = HelloDir.new
FuseFS.set_root(hellodir)

#Montamos sobre un directorio pasado
#como parametro
FuseFS.mount_under ARGV.shift
FuseFS.run
