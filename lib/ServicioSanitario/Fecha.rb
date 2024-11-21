module ServicioSanitario
    class Fecha
      include Comparable
      include Enumerable

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

      def each
        yield dia
        yield mes
        yield anio
      end
      
    end
end
  