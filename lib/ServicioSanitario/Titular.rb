require_relative 'Medico'
require_relative 'NivelSet'
require_relative 'Persona'

# Módulo principal para la gema ServicioSanitario
module ServicioSanitario
    # Clase que representa a un médico titular en el sistema sanitario.
    # Hereda de la clase `Medico` y añade una restricción en el número máximo de pacientes.
    class Titular < Medico
        attr_accessor :maximo_pacientes, :prioridad, :diagnosticos

        def initialize(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento, especialidad, maximo_pacientes)
          # Llama al constructor de la clase base con 6 argumentos
          super(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento, especialidad)
          # Inicializa los atributos específicos de Titular
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
    end 
end 