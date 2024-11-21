module ServicioSanitario
  class Hora
    include Comparable
    include Enumerable

    attr_accessor :hora, :minuto, :segundo
      def initialize(hora:, minuto:, segundo:)
      @hora = hora
      @minuto = minuto
      @segundo = segundo
    end
    
    def to_s
      format("%02d:%02d:%02d", @hora, @minuto, @segundo)
    end

    def <=>(other)
      [hora, minuto, segundo] <=> [other.hora, other.minuto, other.segundo]
    end

    def each
      [hora, minuto, segundo].each { |element| yield element }
    end
    
  end
end
  