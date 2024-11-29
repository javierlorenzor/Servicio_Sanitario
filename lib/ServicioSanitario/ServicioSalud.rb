module ServicioSanitario
  class ServicioSalud
    include Comparable
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
        @camas[indice] = { paciente: paciente, ingreso: ServicioSanitario::Hora }
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
    def num_camas_libres
      @camas.count { |_, ocupado| ocupado.nil? }
    end

    #metodo apra asignar un medico a un paciente 
    def asignar_medico(medico, paciente)
      cama_paciente = @camas.find { |_, ocupacion| ocupacion && ocupacion[:paciente] == paciente }
      if cama_paciente && medico.pacientes.size < 10 
        medico.pacientes << paciente
        true
      else
        false
      end
    end

    # Método para obtener el número de pacientes asignados a médicos
    def pacientes_asignados
      @medicos.sum { |medico| medico.pacientes.size }
    end
    
    def ocupacion_cama(paciente, alta: nil)
      alta ||= ServicioSanitario::Hora.new(hora: 12, minuto: 0, segundo: 0)  # Si no se pasa una fecha de alta, usar una hora predeterminada
    
      # Buscar la cama ocupada por el paciente
      cama_paciente = @camas.find { |_, ocupado| ocupado && ocupado[:paciente] == paciente }
    
      if cama_paciente
        ingreso = cama_paciente[1][:ingreso] # Hora de ingreso (instancia de Hora)
        
        # Si la hora de alta no es proporcionada, usar la hora predeterminada (o puedes usar Time.now para probar)
        hora_alta = alta || ServicioSanitario::Hora.new(hora: 12, minuto: 0, segundo: 0)
    
        # Usamos el método diferencia_horas para calcular la diferencia entre hora de ingreso y hora de alta
        ServicioSanitario.diferencia_horas(ingreso, hora_alta)
      else
        nil # Si no se encuentra la cama ocupada por el paciente
      end
    end
    
    def to_s
      <<~INFO
        Código: #{@codigo}
        Descripción: #{@descripcion}
        Horario: #{@horario_apertura} - #{@horario_cierre}
        Días Festivos: #{@dias_festivos.map(&:to_s).join(', ')}
        Camas Libres: #{num_camas_libres}
        Total de Pacientes Asignados a Médicos: #{pacientes_asignados}
      INFO
    end

    # Implementación del método de comparación basado en el número de camas libres
    def <=>(other)
      # Asegúrate de que otro_servicio no sea nil y tenga el método `num_camas_libres`
      return nil unless other.is_a?(ServicioSanitario::ServicioSalud)
      
      self.num_camas_libres <=> other.num_camas_libres
    end
  end 
end 
