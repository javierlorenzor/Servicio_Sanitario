require_relative 'Medico'
require_relative 'NivelSet'
require_relative 'Persona'

# Módulo principal para la gema ServicioSanitario
module ServicioSanitario
    # Clase que representa a un médico titular en el sistema sanitario.
    # Hereda de la clase `Medico` y añade una restricción en el número máximo de pacientes.
    class Titular < Medico
        attr_accessor :maximo_pacientes

        def initialize(numero_identificacion, nombre_completo, sexo, fecha_nacimiento, prioridad)
            super(numero_identificacion, nombre_completo, sexo, fecha_nacimiento)
            @prioridad = prioridad
            @diagnosticos = []
        end
      
        def carga_max?
            numero_pacientes >= maximo_pacientes
        end

        def to_s
            "Nombre Completo: #{nombre_completo}, ID: #{@numero_identificacion}, Sexo: #{@sexo}, Fecha de Nacimiento: #{obtener_fecha}, Prioridad: #{prioridad}, Diagnósticos: #{diagnosticos.join(', ')}"
        end
    end 
end 