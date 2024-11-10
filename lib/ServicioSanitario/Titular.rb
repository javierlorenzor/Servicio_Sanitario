require_relative 'Medico'
require_relative 'NivelSet'
require_relative 'Persona'

module ServicioSanitario
    attr_accessor :maximo_pacientes

    class Titular < Medico
        def initialize(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento, especialidad, maximo_pacientes)
            super(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento, especialidad)
            @maximo_pacientes = maximo_pacientes
        end

        def carga_maxima_alcanzada?
            @numero_pacientes >= @maximo_pacientes
        end
      
        def to_s
            "#{super()}, Máximo de Pacientes: #{@maximo_pacientes}, Carga Máxima Alcanzada: #{carga_maxima_alcanzada?}"
        end
    end 
end 