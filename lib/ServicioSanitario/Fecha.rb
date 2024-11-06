module ServicioSanitario
    # Clase que representa una fecha (día, mes, año)
    class Fecha
      # Atributos: día, mes y año
      attr_accessor :dia, :mes, :anio
  
      # Inicializa una nueva fecha con día, mes y año.
      #
      # @param dia [Integer] el día de la fecha
      # @param mes [Integer] el mes de la fecha
      # @param anio [Integer] el año de la fecha
      def initialize(dia:, mes:, anio:)
        @dia = dia
        @mes = mes
        @anio = anio
      end
  
      # Devuelve la fecha en formato "día/mes/año"
      #
      # @return [String] la fecha en formato "día/mes/año"
      def to_s
        "#{@dia}/#{@mes}/#{@anio}"
      end
    end
  end
  