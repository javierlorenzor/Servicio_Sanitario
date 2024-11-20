module ServicioSanitario
    # Clase que representa una fecha (día, mes, año)
    class Fecha
      include Comparable
      include Enumerable
      # Atributos: día, mes y año
      attr_accessor :dia, :mes, :anio
  
      def initialize(dia:, mes:, anio:)
        @dia = dia
        @mes = mes
        @anio = anio
      end
  
      def to_s
        "#{@dia}/#{@mes}/#{@anio}"
      end
      
      def <=>(other)
        [anio, mes, dia] <=> [other.anio, other.mes, other.dia]
      end

    end
end
  