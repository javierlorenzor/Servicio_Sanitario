module ServicioSanitario
    class Fecha
        attr_accessor :dia, :mes, :anio
        def initialize(dia:, mes:, anio:)
            @dia = dia
            @mes = mes
            @anio = anio
        end
        
    end
end  