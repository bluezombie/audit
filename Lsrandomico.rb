#!/usr/bin/env ruby
require 'fusefs'
require 'Objeto.rb'

class Obligatorio
  #Constructor
  def initialize
    @archivos = []
    @archivos_randomicos = Array.new(3){Array.new(1)}
    carga_archivos #Cargo algunos archivos en el sistema
  end

  #Metodo utilizado cuando se llama al comando
  #'ls'.
  #Devuelve un string con los nombres de los
  #archivos
  def contents(path)
    logging("contents llamado con el path #{path}")
    salida = []
    randomico = rand(3)
    @archivos_randomicos[randomico].each do |objeto|
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

  #Devuelve un string con el contenido
  #del archivo.
  #Se utiliza al llamarse el comando 'vi'
  def read_file(path)
    logging("read_file llamado con el path #{path}")
    objeto=obtener(path)
    objeto.contenido
  end

  #Metodo que pregunta
  #si el objeto pasado como parametro
  #(ruta) es un directorio
  def directory?(path)
    logging("directory? llamado con el path #{path}")
    return false
  end

  def can_write?(path)
    logging("can_write? llamado con el path #{path}")
    objeto=obtener(path)
    objeto.modificable?
  end

  #Devuelve el tamano del archivo
  #pasado como parametro
  def size(path)
    logging("size llamado con el path #{path}")
    objeto=obtener(path)
    objeto.size
  end
  
  #Carga de archivos en el sistema
  def carga_archivos
    archivo1=Objeto.new("hola.txt",666,true)
    archivo1.contenido="Soy el archivo 1\n"
    @archivos.push(archivo1)
    archivo2=Objeto.new("sistemasoperativo.txt",2048,false)
    archivo2.contenido="Soy el archivo sistemasoperativos.txt\n"
    @archivos.push(archivo2)
    archivo3=Objeto.new("multilinea.lst",1111,true)
    archivo3.contenido="Linea 1\nLinea 2\nLinea3\n"
    @archivos.push(archivo3)
    @archivos_randomicos[0].push(Objeto.new("Steve_Jobs.mac",1024,false))
    @archivos_randomicos[0].push(Objeto.new("Bill_Gates.win",666,false))
    @archivos_randomicos[0].push(Objeto.new("Linus_Torvalds.lin",1,false))
    @archivos_randomicos[1].push(Objeto.new("Harvey_Deitel.bk",666,false))
    @archivos_randomicos[1].push(Objeto.new("Andrew_Tanenbaum.bk",1024,false))
    @archivos_randomicos[1].push(Objeto.new("Abraham_Silberschatz.lin",10240,true))
    @archivos_randomicos[2].push(Objeto.new("Intel.chip",1024,false))
    @archivos_randomicos[2].push(Objeto.new("AMD.chip",1024,false))
    @archivos_randomicos[0].delete_at(0)
    @archivos_randomicos[1].delete_at(0)
    @archivos_randomicos[2].delete_at(0)
    @archivos.push(Objeto.new("Steve_Jobs.mac",1024,false))
    @archivos.push(Objeto.new("Bill_Gates.win",666,false))
    @archivos.push(Objeto.new("Linus_Torvalds.lin",1,false))
    @archivos.push(Objeto.new("Harvey_Deitel.bk",666,false))
    @archivos.push(Objeto.new("Andrew_Tanenbaum.bk",1024,false))
    @archivos.push(Objeto.new("Abraham_Silberschatz.lin",10240,true))
    @archivos.push(Objeto.new("Intel.chip",1024,false))
    @archivos.push(Objeto.new("AMD.chip",1024,false))
  end

  #A partir del path pasado por la system call
  #obtengo el objeto asociado
  #Esto sirve como entrada para mostrar
  #el contenido del archivo, saber si es un
  #directorio, obtener el nombre, etc
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

  #Metodo auxiliar utilizado para mostrar
  #en consola los metodos llamados
  def logging(mensaje)
    hora = Time.now.strftime("%H:%M:%S")
    puts hora + " | " + mensaje
  end
end

obligatorio1 = Obligatorio.new
FuseFS.set_root(obligatorio1)

#Montamos sobre un directorio pasado
#como parametro
FuseFS.mount_under ARGV.shift
FuseFS.run
