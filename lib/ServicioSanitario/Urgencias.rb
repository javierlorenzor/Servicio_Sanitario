module ServicioSanitario
    class Urgencias < ServicioSalud
        attr_accessor :camas_uci

        def initialize(codigo:, descripcion:, horario_apertura:, horario_cierre:, dias_festivos:, medicos:, camas:, camas_uci:)
          super(codigo: codigo, descripcion: descripcion, horario_apertura: horario_apertura,
                horario_cierre: horario_cierre, dias_festivos: dias_festivos, medicos: medicos, camas: camas)
          @camas_uci = camas_uci
        end
      
        def to_s
            super + "Camas UCI Disponibles:#{@camas_uci}\n"
        end
      
      
    end
end 