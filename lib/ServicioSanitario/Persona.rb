# Módulo principal para la gema ServicioSanitario
module ServicioSanitario
    # Clase que representa una persona en el sistema sanitario.
    # Esta clase sirve como clase base para otras entidades del sistema que comparten atributos comunes.
    class Persona
        include Comparable
        include Enumerable
        attr_accessor :numero_identificacion, :sexo , :fecha_nacimiento   
       
        def initialize(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento)
            @numero_identificacion = numero_identificacion
            #set_nombre_completo(nombre_completo)
            set_nombre_completo("#{nombre} #{apellido}")
            @sexo = sexo
            @fecha_nacimiento = fecha_nacimiento

            # Incrementa el contador cada vez que se crea una nueva instancia
            if defined?(@@instancia_contador)
                @@instancia_contador += 1
            else
                @@instancia_contador = 1
            end
        end
        
        def nombre_completo
            @nombre + ' ' + @apellido
        end
      
        def obtener_fecha
            @fecha_nacimiento
        end
        
        def edad(fecha_actual)
            # Usamos el método obtener_fecha para acceder a la fecha de nacimiento
            fecha_nacimiento = obtener_fecha
        
            # Calculamos la edad
            edad = fecha_actual.anio - fecha_nacimiento.anio
        
            # Si la fecha actual aún no ha llegado al mes o día de nacimiento, restamos un año
            if fecha_actual.mes < fecha_nacimiento.mes || (fecha_actual.mes == fecha_nacimiento.mes && fecha_actual.dia < fecha_nacimiento.dia)
                edad -= 1
            end
        
            edad
        end
        
        def to_s
            "Nombre: #{nombre_completo}, ID: #{@numero_identificacion}, Sexo: #{@sexo}, Fecha de nacimiento: #{@fecha_nacimiento}"
        end
      
        def set_nombre_completo(nombre_completo)
            nombre, apellido = nombre_completo.split(/\s+/)
            set_nombre(nombre)
            set_apellido(apellido)
        end

        def self.contador_instancias
            @@instancia_contador
        end
        
        def <=>(other)
            return nil unless other.is_a?(Persona)
            fecha_actual = ServicioSanitario::Fecha.new(dia: 15, mes: 11, anio: 2024)
            self.edad(fecha_actual) <=> other.edad(fecha_actual)
        end

        def each
            yield @numero_identificacion
            yield nombre_completo # Accedemos a través de nombre_completo
            yield @sexo
            yield obtener_fecha # Accedemos a través de obtener_fecha
        end
  
        private

        def set_nombre(nombre)
            @nombre = nombre
        end

        def set_apellido(apellido)
            @apellido = apellido
        end
        
        public :nombre_completo, :obtener_fecha, :edad, :to_s, :set_nombre_completo
        protected :fecha_nacimiento
        private :set_nombre, :set_apellido

    end
end