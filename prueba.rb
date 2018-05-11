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
    puts "#{nombre} aprobo con promedio #{promedio}"if promedio >= 5
  end  
end  

abrir_archivo(alumnos)
print alumnos

while true
  puts "\nIngrese opcion"
  opcion = gets.chomp.to_i
  
  case opcion
  when 1 ##promedio de notas


    alumnos.each do |nombre, array_notas|
      alumnos_promedios.store(nombre, array_notas.inject(0) { |acc, valor| acc + valor } / array_notas.length)  

      File.open( 'alumnos/'+nombre+".txt",'w') { |archivo| archivo.puts( 
        array_notas.inject(0) { |acc, valor| acc + valor } / array_notas.length) }
    end
    puts "Archivos creados!"
    print alumnos_promedios

  when 2 ##mostrar total inasistencias
      suma = 0
      alumnos.values.each do
        |nota_alumno| suma += nota_alumno.count(0)
      end
      puts "Hay #{suma} inasistencias"

  when 3 ##comprobar si alumnos aprueban
      comprobar_aprobacion(alumnos_promedios, 5)

  when 4
    break

  else
    puts 'Opcion invalida'
  end 
end
