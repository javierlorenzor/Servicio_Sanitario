module ServicioSanitario
    class Urgencias < ServicioSalud
        include Comparable
        attr_accessor :camas_uci

        def initialize(codigo:, descripcion:, horario_apertura:, horario_cierre:, dias_festivos:, medicos:, camas:, camas_uci:)
          super(codigo: codigo, descripcion: descripcion, horario_apertura: horario_apertura,
                horario_cierre: horario_cierre, dias_festivos: dias_festivos, medicos: medicos, camas: camas)
          @camas_uci = camas_uci
        end
      
        def to_s
            super + "Camas UCI Disponibles:#{@camas_uci}\n"
        end

        def <=>(other)
            return nil unless other.is_a?(ServicioSanitario::ServicioSalud)
            
            camas_totales = self.num_camas_libres + (@camas_uci || 0)
            otras_camas_totales = other.num_camas_libres + (other.respond_to?(:camas_uci) ? other.camas_uci : 0)
      
            camas_totales <=> otras_camas_totales
        end
      
    end
end 