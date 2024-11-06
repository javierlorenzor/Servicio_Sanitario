# El módulo ServicioSanitario contiene la clase Hora que representa una hora específica.
module ServicioSanitario
    # Clase que define una hora con los atributos hora, minuto y segundo.
    class Hora
      # Definimos los atributos de la clase: hora, minuto y segundo
      attr_accessor :hora, :minuto, :segundo
    
      # Constructor de la clase Hora, inicializa los atributos con los valores pasados como parámetros.
      #
      # @param hora [Integer] La hora en formato de 24 horas (0-23)
      # @param minuto [Integer] Los minutos (0-59)
      # @param segundo [Integer] Los segundos (0-59)
      def initialize(hora:, minuto:, segundo:)
        @hora = hora
        @minuto = minuto
        @segundo = segundo
      end
      
      # Método que devuelve la representación en cadena de la hora en formato HH:MM:SS.
      #
      # @return [String] La hora formateada como una cadena con ceros a la izquierda si es necesario
      def to_s
        # Usamos format para dar formato a la hora en dos dígitos (con ceros a la izquierda si es necesario)
        format("%02d:%02d:%02d", @hora, @minuto, @segundo)
      end
    end
  end
  