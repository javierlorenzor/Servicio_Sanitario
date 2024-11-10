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
    
    end 
end