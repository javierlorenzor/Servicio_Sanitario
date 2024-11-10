require_relative 'Medico'
require_relative 'NivelSet'

module ServicioSanitario
    class Titular < Medico
        def initialize(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento, especialidad, maximo_pacientes)
            super(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento, especialidad)
            @maximo_pacientes = maximo_pacientes
        end
    end 
end 