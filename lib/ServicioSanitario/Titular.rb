require_relative 'Medico'
require_relative 'NivelSet'
require_relative 'Persona'

module ServicioSanitario
    class Titular < Medico
        attr_accessor :maximo_pacientes

        def initialize(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento, especialidad, maximo_pacientes)
            super(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento, especialidad)
            @maximo_pacientes = maximo_pacientes
        end

        def carga_max?
            numero_pacientes >= maximo_pacientes
        end
       
    end 
end 