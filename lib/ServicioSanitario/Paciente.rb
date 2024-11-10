require_relative 'Persona'
require_relative 'NivelSet'

module ServicioSanitario
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
            "#{super()}, Prioridad: #{prioridad}, Diagnósticos: #{diagnosticos.join(', ')}"
        end

    end
end