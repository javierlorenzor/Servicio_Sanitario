module ServicioSanitario
  class ServicioSanitarioDSL
    def initialize(&block)
      @servicios = []
      @usuarios = []

      if block_given?
        if block.arity == 1
          yield self
        else
          instance_eval(&block)
        end
      end
    end

    def servicio(tipo, codigo:, descripcion:, horario_apertura:, horario_cierre:, dias_festivos: [], medicos: [], camas: {}, numero_plantas: nil)
      servicio = if tipo == :hospital
        Hospital.new(
          codigo: codigo, 
          descripcion: descripcion, 
          horario_apertura: horario_apertura,
          horario_cierre: horario_cierre, 
          dias_festivos: dias_festivos, 
          medicos: medicos,
          camas: camas, 
          numero_plantas: numero_plantas
        )
      else
        ServicioSalud.new(
          codigo: codigo, 
          descripcion: descripcion, 
          horario_apertura: horario_apertura,
          horario_cierre: horario_cierre, 
          dias_festivos: dias_festivos, 
          medicos: medicos, 
          camas: camas
        )
      end
      @servicios << servicio
    end

  end
end
  