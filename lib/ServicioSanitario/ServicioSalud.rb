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

        #metodo para asignar un paciente a una cama 
        def asignar_cama(paciente)
            cama_libre = @camas.find { |indice, ocupado| ocupado.nil? }
            if cama_libre
              indice = cama_libre[0]
              @camas[indice] = { paciente: paciente, ingreso: Time.now }
              indice
            else
              nil
            end
        end
        
        #método para liberar una cama 
        def liberar_cama(indice_cama)
            if @camas.key?(indice_cama)
              @camas[indice_cama] = nil
              true
            else
              false
            end
        end

        # Método para contar el número de camas libres
        def numero_camas_libres
            @camas.count { |_, ocupado| ocupado.nil? }
        end

        #metodo apra asignar un medico a un paciente 
        def asignar_medico(medico, paciente)
            cama_paciente = @camas.find { |_, ocupacion| ocupacion && ocupacion[:paciente] == paciente }
            if cama_paciente && medico.pacientes.size < 10 # Ejemplo de límite de pacientes
              medico.pacientes << paciente
              true
            else
              false
            end
        end

    end 
end 
