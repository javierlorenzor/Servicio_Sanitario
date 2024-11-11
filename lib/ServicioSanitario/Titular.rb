require_relative 'Medico'
require_relative 'NivelSet'
require_relative 'Persona'

# Módulo principal para la gema ServicioSanitario
module ServicioSanitario
    # Clase que representa a un médico titular en el sistema sanitario.
    # Hereda de la clase `Medico` y añade una restricción en el número máximo de pacientes.
    class Titular < Medico
        attr_accessor :maximo_pacientes

        # Inicializa un nuevo objeto `Titular`.
        #
        # @param numero_identificacion [String] Número de identificación del médico titular.
        # @param nombre [String] Nombre del médico titular.
        # @param apellido [String] Apellido del médico titular.
        # @param sexo [String] Sexo del médico titular.
        # @param fecha_nacimiento [Date] Fecha de nacimiento del médico titular.
        # @param especialidad [String] Especialidad médica del médico titular.
        # @param maximo_pacientes [Integer] Número máximo de pacientes que puede manejar.
        def initialize(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento, especialidad, maximo_pacientes)
            super(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento, especialidad)
            @maximo_pacientes = maximo_pacientes
        end

        # Verifica si el médico titular ha alcanzado el máximo de pacientes permitidos.
        #
        # @return [Boolean] `true` si el número de pacientes es igual o mayor al máximo permitido, `false` en caso contrario.
        def carga_max?
            numero_pacientes >= maximo_pacientes
        end

        # Representación en cadena del médico titular, que incluye el máximo de pacientes y si ha alcanzado la carga máxima.
        #
        # @return [String] Descripción detallada del médico titular.
        public
        def to_s
            "#{super()}, Máximo de Pacientes: #{@maximo_pacientes}, Carga Máxima Alcanzada: #{carga_max?}"
        end
    end 
end 