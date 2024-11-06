module ServicioSanitario
    # Clase NivelSet que representa el nivel de atención, categoría y tiempo de atención
    class NivelSet
      # Atributos de lectura para el nivel, la categoría y el tiempo de atención
      attr_reader :nivel, :categoria, :tiempo_atencion
      
      # Inicializa una nueva instancia de NivelSet con nivel, categoría y tiempo de atención
      #
      # @param nivel [Symbol] El nivel de atención (Ej. :I, :II, etc.)
      # @param categoria [String] La categoría asociada al nivel (Ej. 'Reanimacion', 'Emergencia', etc.)
      # @param tiempo_atencion [String] El tiempo de atención (Ej. 'Inmediato', '7 minutos', etc.)
      def initialize(nivel, categoria, tiempo_atencion)
        @nivel = nivel
        @categoria = categoria
        @tiempo_atencion = tiempo_atencion
      end
      
      # Devuelve una representación en cadena del objeto NivelSet
      #
      # @return [String] Una cadena que describe el nivel, la categoría y el tiempo de atención
      def to_s
        "Nivel: #{@nivel}, Categoría: #{@categoria}, Tiempo de atención: #{@tiempo_atencion}"
      end
    end
end
  