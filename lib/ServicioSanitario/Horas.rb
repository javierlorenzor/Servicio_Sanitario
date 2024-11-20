# El módulo ServicioSanitario contiene la clase Hora que representa una hora específica.
module ServicioSanitario
  # Clase que define una hora con los atributos hora, minuto y segundo.
  class Hora
    include Comparable
    include Enumerable
    # Definimos los atributos de la clase: hora, minuto y segundo
    attr_accessor :hora, :minuto, :segundo
  

    def initialize(hora:, minuto:, segundo:)
      @hora = hora
      @minuto = minuto
      @segundo = segundo
    end
    
    def to_s
      # Usamos format para dar formato a la hora en dos dígitos (con ceros a la izquierda si es necesario)
      format("%02d:%02d:%02d", @hora, @minuto, @segundo)
    end

    def <=>(other)
      [hora, minuto, segundo] <=> [other.hora, other.minuto, other.segundo]
    end

    
  end
end
  