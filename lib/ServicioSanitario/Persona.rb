module ServicioSanitario
    class Persona
        def initialize(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento)
            @numero_identificacion = numero_identificacion
            @nombre = nombre
            @apellido = apellido
            @sexo = sexo
            @fecha_nacimiento = fecha_nacimiento
        end
        def to_s
            "#{@nombre} #{@apellido}, ID: #{@numero_identificacion}, Sexo: #{@sexo}, Fecha de Nacimiento: #{@fecha_nacimiento}"
        end
    end
end