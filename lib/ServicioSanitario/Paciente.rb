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


    end
end