require_relative 'Persona'
require_relative 'NivelSet'

# Módulo principal para la gema ServicioSanitario
module ServicioSanitario
    # Clase que representa a un paciente en el sistema sanitario.
    # Hereda de `Persona` e incluye atributos y métodos específicos para pacientes.
    class Paciente < Persona
        attr_accessor :prioridad, :diagnosticos
        # Inicializa un nuevo objeto `Paciente`.
        #
        # @param numero_identificacion [String] Número de identificación del paciente.
        # @param nombre [String] Nombre del paciente.
        # @param apellido [String] Apellido del paciente.
        # @param sexo [String] Sexo del paciente.
        # @param fecha_nacimiento [Date] Fecha de nacimiento del paciente.
        # @param prioridad [NivelSet] Nivel de prioridad del paciente.
        def initialize(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento, prioridad)
            super(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento)
            @prioridad = prioridad
            @diagnosticos = []
        end

        # Obtiene el último diagnóstico registrado para el paciente.
        #
        # @return [String, nil] El último diagnóstico del paciente o `nil` si no tiene diagnósticos.
        def ultimo_diagnostico
            diagnosticos.last
        end
        
        # Representación en cadena del paciente.
        #
        # @return [String] Una descripción detallada del paciente, incluyendo prioridad y diagnósticos.
        def to_s
            "#{super()}, Prioridad: #{prioridad}, Diagnósticos: #{diagnosticos.join(', ')}"
        end
    end
end