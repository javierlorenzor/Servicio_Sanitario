module ServicioSanitario
    class Persona
        def initialize(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento)
            @numero_identificacion = numero_identificacion
            @nombre = nombre
            @apellido = apellido
            @sexo = sexo
            @fecha_nacimiento = fecha_nacimiento

            # Incrementa el contador cada vez que se crea una nueva instancia
            if defined?(@@instancia_contador)
                @@instancia_contador += 1
            else
                @@instancia_contador = 1
            end
        end
        
        # Método para obtener el contador de instancias
        def self.contador_instancias
            @@instancia_contador
        end
        
        def edad(fecha)
            fecha.anio - @fecha_nacimiento.anio
        end

        def to_s
            "#{@nombre} #{@apellido}, ID: #{@numero_identificacion}, Sexo: #{@sexo}, Fecha de Nacimiento: #{@fecha_nacimiento}"
        end
    end
end