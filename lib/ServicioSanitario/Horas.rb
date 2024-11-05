module ServicioSanitario
    class Hora
        attr_accessor :hora, :minuto, :segundo
    
        def initialize(hora:, minuto:, segundo:)
            @hora = hora
            @minuto = minuto
            @segundo = segundo
          end
      
    end
end  