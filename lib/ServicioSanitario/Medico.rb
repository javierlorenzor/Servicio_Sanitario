require_relative 'Persona'
require_relative 'NivelSet'

# Módulo principal para la gema ServicioSanitario
module ServicioSanitario
    include Comparable
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
        "#{nombre_completo}, ID: #{@numero_identificacion}, Sexo: #{@sexo}, Fecha de Nacimiento: #{obtener_fecha}, Especialidad: #{@especialidad}, Número de Pacientes: #{numero_pacientes}"
       end
       
       def <=>(other)
        # Comparar el número de pacientes entre los médicos
        numero_pacientes <=> other.numero_pacientes
       end

      def each
        yield @numero_identificacion
        yield nombre_completo
        yield @sexo
        yield obtener_fecha
        yield @especialidad
        yield numero_pacientes
        # Iterar sobre cada paciente
        @pacientes.each do |paciente|
          yield paciente
        end
      end

    end 
end