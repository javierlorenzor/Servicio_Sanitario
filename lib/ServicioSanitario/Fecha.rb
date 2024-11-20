module ServicioSanitario
    # Clase que representa una fecha (día, mes, año)
    class Fecha
      include Comparable
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
    end
end
  