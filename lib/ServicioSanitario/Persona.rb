# Módulo principal para la gema ServicioSanitario
module ServicioSanitario
    # Clase que representa una persona en el sistema sanitario.
    # Esta clase sirve como clase base para otras entidades del sistema que comparten atributos comunes.
    class Persona
        attr_accessor :numero_identificacion, :nombre, :apellido, :sexo, :fecha_nacimiento
        #Inicializa un nuevo objeto `Persona`.
        #
        # @param numero_identificacion [String] Número de identificación de la persona.
        # @param nombre [String] Nombre de la persona.
        # @param apellido [String] Apellido de la persona.
        # @param sexo [String] Sexo de la persona.
        # @param fecha_nacimiento [Date] Fecha de nacimiento de la persona.
        def initialize(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento)
            @numero_identificacion = numero_identificacion
            @nombre = nombre
            @apellido = apellido
            @sexo = sexo
            @fecha_nacimiento = fecha_nacimiento

            # Incrementa el contador cada vez que se crea una nueva instancia
            if defined?(@@instancia_contador)
                @@instancia_contador += 1
            else
                @@instancia_contador = 1
            end
        end
        
        protected
       # Método de clase para obtener el número total de instancias creadas de `Persona`.
        #
        # @return [Integer] El contador de instancias de la clase `Persona`.
        def self.contador_instancias
            @@instancia_contador
        end

        # Calcula la edad de la persona en función de una fecha específica.
        #
        # @param fecha [Date] La fecha con respecto a la cual calcular la edad.
        # @return [Integer] La edad de la persona en años.
        public
        def edad(fecha)
            fecha.anio - @fecha_nacimiento.anio
        end

        # Representación en cadena de la persona.
        #
        # @return [String] Una descripción detallada de la persona.
        def to_s
            "#{@nombre} #{@apellido}, ID: #{@numero_identificacion}, Sexo: #{@sexo}, Fecha de Nacimiento: #{@fecha_nacimiento}"
        end
    end
end