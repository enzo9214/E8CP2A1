alumnos = {}
alumnos_promedios = {}

def abrir_archivo(hash)
  data = File.open('notas.csv','r') { |archivo| archivo.readlines }

  data = data.map{ |data| data.chomp.split(', ') }

  data.each do |info|
    hash[info[0]] = [info[1], info[2], info[3], info[4], info[5]] 
  end
    
  hash.each do |nombre,array_notas|
    hash[nombre] = array_notas.map{ |nota| 
      if nota != 'A'
        nota.to_i
      else
        nota = 0  
      end  
      }
  end

  hash
end

def comprobar_aprobacion(hash, nota_minima)
  hash.each do |nombre, promedio|
    puts "#{nombre} aprobo con promedio #{promedio}" if promedio >= nota_minima
  end  
end  

## cargando data en init
abrir_archivo(alumnos)
#print alumnos

alumnos.each do |nombre, array_notas|
      alumnos_promedios.store(nombre, array_notas.inject(0) { |acc, valor| acc + valor } / array_notas.length) 
end
##print alumnos_promedios

while true
  puts "\nIngrese opcion"
  opcion = gets.chomp.to_i
  
  case opcion
  when 1 ##promedio de notas

      File.open( "alumnos/Promedios.txt",'w') do |archivo| 
         alumnos_promedios.each do |nombre, promedio|
          archivo.puts "#{nombre} #{promedio}"
         end
      end
  
    puts "Archivo creado!"
    print alumnos_promedios

  when 2 ##mostrar total inasistencias
      suma = 0
      alumnos.values.each do
        |nota_alumno| suma += nota_alumno.count(0)
      end
      puts "Hay #{suma} inasistencias"

  when 3 ##comprobar si alumnos aprueban
      puts "Ingresa nota minima de aprobacion"
      nota_minima = gets.chomp.to_i

      if nota_minima == 0
        nota_minima = 5
      end

      comprobar_aprobacion(alumnos_promedios, nota_minima)

  when 4
    break

  else
    puts 'Opcion invalida'
  end 
end
