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

    # Método para calcular el índice de capacidad de respuesta
    def calcular_indice_respuesta
      # Calcular el tiempo medio de ocupación (en minutos)
      tiempos_ocupacion = @camas.values.map do |cama|
        if cama
          ingreso = cama[:ingreso]
          alta = ServicioSanitario::Hora.new(hora: 12, minuto: 0, segundo: 0) # Hora fija para cálculo
          # Diferencia en minutos entre ingreso y alta
          horas, minutos, _ = ServicioSanitario.diferencia_horas(ingreso, alta).split(/[^0-9]+/).map(&:to_i)
          horas * 60 + minutos
        else
          nil
        end
      end.compact
    
    
    
      tiempo_promedio_ocupacion = tiempos_ocupacion.sum / tiempos_ocupacion.size.to_f
    
      # Clasificar tiempo medio de ocupación
      tiempo_puntaje = if tiempo_promedio_ocupacion >= 30.0
                        1 # Aceptable
                      elsif tiempo_promedio_ocupacion > 15.0
                        2 # Bueno
                      else
                        3 # Excelente
                      end
    
    
      # Calcular el ratio de facultativos por paciente
      total_pacientes = pacientes_asignados
      total_medicos = @medicos.size
    
    
      if total_pacientes.zero?
        ratio_puntaje = 3 # Excelente por defecto si no hay pacientes
      else
        ratio = total_medicos.to_f / total_pacientes
        ratio_puntaje = if ratio >= 1.0 / 5 && ratio <= 1.0 / 3
                          1 # Aceptable
                        elsif ratio > 1.0 / 3 && ratio <= 1.0 / 2
                          2 # Bueno
                        else
                          3 # Excelente
                        end
      end
    
    
      # Calcular el índice de capacidad de respuesta como promedio de los dos puntajes
      indice_respuesta = (tiempo_puntaje + ratio_puntaje) / 2.0
      
    
      indice_respuesta.round
    end
    

    # Implementación del operador de comparación basado en el índice de respuesta
    def <=>(other)
      return nil unless other.is_a?(ServicioSanitario::ServicioSalud)

      calcular_indice_respuesta <=> other.calcular_indice_respuesta
    end
  end 
end 
