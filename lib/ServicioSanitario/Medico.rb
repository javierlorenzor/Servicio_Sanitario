require_relative 'Persona'
require_relative 'NivelSet'

# Módulo principal para la gema ServicioSanitario
module ServicioSanitario
    # Clase que representa a un médico en el sistema sanitario.
    # Hereda de la clase `Persona` y añade propiedades específicas para un médico.
    class Medico < Persona
        attr_accessor :especialidad, :pacientes

        # Inicializa un nuevo objeto `Medico`.
        #
        # @param numero_identificacion [String] Número de identificación del médico.
        # @param nombre [String] Nombre del médico.
        # @param apellido [String] Apellido del médico.
        # @param sexo [String] Sexo del médico.
        # @param fecha_nacimiento [Date] Fecha de nacimiento del médico.
        # @param especialidad [String] Especialidad médica del médico.
        def initialize(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento, especialidad)
            super(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento)
            @especialidad = especialidad
            @pacientes = []
        end

        # Devuelve el número de pacientes asignados al médico.
        #
        # @return [Integer] Cantidad de pacientes asignados.
        def numero_pacientes
            @pacientes.size
        end
        
        # Representación en cadena del médico, que incluye la especialidad y el número de pacientes.
        #
        # @return [String] Descripción detallada del médico.
        def to_s
            "#{super()}, Especialidad: #{@especialidad}, Número de Pacientes: #{numero_pacientes}"
        end

    end 
end