module ServicioSanitario
    class Hospital < ServicioSalud
        attr_accessor :numero_plantas

        def initialize(codigo:, descripcion:, horario_apertura:, horario_cierre:, dias_festivos:, medicos:, camas:, numero_plantas:)
        super(codigo: codigo, descripcion: descripcion, horario_apertura: horario_apertura,
                horario_cierre: horario_cierre, dias_festivos: dias_festivos, medicos: medicos, camas: camas)
        @numero_plantas = numero_plantas # Número de plantas del hospital
        end

        def to_s
            super + "Número de Plantas: #{@numero_plantas}"
        end

        def <=>(other)
            return nil unless other.is_a?(ServicioSanitario::ServicioSalud)
      
            camas_totales = self.num_camas_libres
            otras_camas_totales = other.num_camas_libres
      
            resultado_camas = camas_totales <=> otras_camas_totales
            return resultado_camas unless resultado_camas == 0
      
            # Si tienen el mismo número de camas, se compara por el número de plantas
            self.numero_plantas <=> (other.respond_to?(:numero_plantas) ? other.numero_plantas : 0)
        end
      
    end 
end 
