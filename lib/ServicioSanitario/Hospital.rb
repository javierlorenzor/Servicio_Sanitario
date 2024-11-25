module ServicioSanitario
    class Hospital < ServicioSalud
        attr_accessor :numero_plantas

        def initialize(codigo:, descripcion:, horario_apertura:, horario_cierre:, dias_festivos:, medicos:, camas:, numero_plantas:)
        super(codigo: codigo, descripcion: descripcion, horario_apertura: horario_apertura,
                horario_cierre: horario_cierre, dias_festivos: dias_festivos, medicos: medicos, camas: camas)
        @numero_plantas = numero_plantas # Número de plantas del hospital
        end

    end 
end 
