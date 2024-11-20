module ServicioSanitario
  # Clase NivelSet que representa el nivel de atención, categoría y tiempo de atención
  class NivelSet
    include Comparable
    include Enumerable
    attr_reader :nivel, :categoria, :tiempo_atencion
    
    def initialize(nivel, categoria, tiempo_atencion)
      @nivel = nivel
      @categoria = categoria
      @tiempo_atencion = tiempo_atencion
    end
    
    def to_s
      "Nivel: #{@nivel}, Categoría: #{@categoria}, Tiempo de atención: #{@tiempo_atencion}"
    end

    def <=>(other)
      tiempo_atencion <=> other.tiempo_atencion
    end

 
    
  end
end
  