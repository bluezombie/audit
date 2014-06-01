#!/usr/bin/env ruby
require 'fusefs'

class HelloDir
  def contents(path)
    ['hello.txt']
  end
  def file?(path)
    path == '/hello.txt'
  end
  def read_file(path)
    "Hello, World!\n"
  end
end

hellodir = HelloDir.new
FuseFS.set_root(hellodir)

#Montamos sobre un directorio pasado
#como parametro
FuseFS.mount_under ARGV.shift
FuseFS.run
