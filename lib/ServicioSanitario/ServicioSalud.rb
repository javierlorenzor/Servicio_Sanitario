module ServicioSanitario
    class ServicioSalud
        attr_accessor :codigo, :descripcion, :horario_apertura, :horario_cierre, :dias_festivos, :medicos, :camas
        def initialize(codigo:, descripcion:, horario_apertura:, horario_cierre:, dias_festivos:, medicos:, camas:)
            @codigo = codigo
            @descripcion = descripcion
            @horario_apertura = horario_apertura # Instancia de Hora
            @horario_cierre = horario_cierre     # Instancia de Hora
            @dias_festivos = dias_festivos       # Array de instancias de Fecha
            @medicos = medicos                   # Array de instancias de Medico
            @camas = camas                       # Hash con camas y ocupaciones
        end
    end 
end 
