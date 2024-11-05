module ServicioSanitario
    class Fecha
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