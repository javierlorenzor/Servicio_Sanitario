require_relative 'Persona'
require_relative 'NivelSet'

# Módulo principal para la gema ServicioSanitario
module ServicioSanitario
    # Clase que representa a un paciente en el sistema sanitario.
    # Hereda de `Persona` e incluye atributos y métodos específicos para pacientes.
    class Paciente < Persona
        attr_accessor :prioridad, :diagnosticos

        def initialize(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento, prioridad)
            super(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento)
            @prioridad = prioridad
            @diagnosticos = []
        end


        def ultimo_diagnostico
            diagnosticos.last
        end

        def to_s
            "#{nombre_completo}, ID: #{@numero_identificacion}, Sexo: #{@sexo}, Fecha de Nacimiento: #{obtener_fecha}, Prioridad: #{prioridad}, Diagnósticos: #{diagnosticos.join(', ')}"
        end

   
        
    end
end