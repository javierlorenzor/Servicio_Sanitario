module ServicioSanitario
    class Hora
        attr_accessor :hora, :minuto, :segundo
    
        def initialize(hora:, minuto:, segundo:)
            @hora = hora
            @minuto = minuto
            @segundo = segundo
        end
        
        def to_s
            format("%02d:%02d:%02d", @hora, @minuto, @segundo)
        end
    end
end  