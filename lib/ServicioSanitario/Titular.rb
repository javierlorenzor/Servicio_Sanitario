require_relative 'Medico'
require_relative 'NivelSet'
require_relative 'Persona'


module ServicioSanitario
    class Titular < Medico
        attr_accessor :maximo_pacientes, :prioridad, :diagnosticos

        def initialize(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento, especialidad, maximo_pacientes)
          super(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento, especialidad)
          @maximo_pacientes = maximo_pacientes
          @prioridad = prioridad
          @diagnosticos = []
        end 
      
        def carga_max?
            numero_pacientes >= maximo_pacientes
        end

        def to_s
            "#{nombre_completo}, ID: #{@numero_identificacion}, Sexo: #{@sexo}, Fecha de Nacimiento: #{obtener_fecha}, Especialidad: #{@especialidad}, Número de Pacientes: #{numero_pacientes}, Máximo de Pacientes: #{@maximo_pacientes}, Carga Máxima Alcanzada: #{carga_max?}"
        end

        def each
            yield @numero_identificacion
            yield nombre_completo
            yield @sexo
            yield obtener_fecha
            yield @especialidad
            yield numero_pacientes
            yield @maximo_pacientes
            @pacientes.each { |paciente| yield paciente }
        end
    end 
end 