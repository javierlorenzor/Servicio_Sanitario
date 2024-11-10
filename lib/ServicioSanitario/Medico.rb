require_relative 'Persona'
require_relative 'NivelSet'

module ServicioSanitario
    class Medico < Persona
        attr_accessor :especialidad, :pacientes

        def initialize(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento, especialidad)
            super(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento)
            @especialidad = especialidad
            @pacientes = []
        end

        def numero_pacientes
            @pacientes.size
        end
        
        def to_s
            "#{super()}, Especialidad: #{@especialidad}, Número de Pacientes: #{numero_pacientes}"
        end

    end 
end