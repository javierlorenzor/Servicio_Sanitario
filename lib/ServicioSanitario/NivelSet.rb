module ServicioSanitario
  # Clase NivelSet que representa el nivel de atención, categoría y tiempo de atención
  class NivelSet
    include Comparable
    include Enumerable
    attr_reader :nivel, :categoria, :tiempo_atencion
    
    def initialize(nivel, categoria, tiempo_atencion)
      @nivel = nivel
      @categoria = categoria
      @tiempo_atencion = parse_tiempo(tiempo_atencion)
    end
    
    def to_s
      "Nivel: #{@nivel}, Categoría: #{@categoria}, Tiempo de atención: #{@tiempo_atencion}"
    end

    def <=>(other)
      other.tiempo_atencion <=> tiempo_atencion
    end

    def each
      yield nivel
      yield categoria
      yield tiempo_atencion
    end

    def parse_tiempo(tiempo)
      return 0 if tiempo.downcase == 'inmediato' 
      tiempo.to_i 
    end

  end
end
  