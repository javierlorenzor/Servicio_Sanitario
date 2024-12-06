# frozen_string_literal: true
require_relative "ServicioSanitario/version"

module ServicioSanitario

  # Definición de constantes para los diferentes niveles de atención, cada una con su nivel, categoría y tiempo de atención
  AZUL = { nivel: :I, categoria: :Reanimacion, tiempo_atencion: :Inmediato }
  ROJO = { nivel: :II, categoria: :Emergencia, tiempo_atencion: '7 minutos' }
  NARANJA = { nivel: :III, categoria: :Urgente, tiempo_atencion: '30 minutos' }
  VERDE = { nivel: :IV, categoria: :Menos_urgente, tiempo_atencion: '45 minutos' }
  NEGRO = { nivel: :V, categoria: :No_urgente, tiempo_atencion: '60 minutos' }

  # Método para calcular la diferencia en tiempo entre dos fechas dadas.
  def self.diferencia(fecha1, fecha2)
    dia1, mes1, anio1 = fecha1.dia, fecha1.mes, fecha1.anio
    dia2, mes2, anio2 = fecha2.dia, fecha2.mes, fecha2.anio
    total_dias_1 = anio1 * 365 + mes1 * 30 + dia1
    total_dias_2 = anio2 * 365 + mes2 * 30 + dia2
    diferencia = (total_dias_2 - total_dias_1).abs
    años = diferencia / 365
    meses = (diferencia % 365) / 30
    dias = (diferencia % 365) % 30
    "#{años} años, #{meses} meses, #{dias} días"
  end

  # Método para calcular la diferencia en horas, minutos y segundos entre dos horas dadas
  def self.diferencia_horas(hora1, hora2)
    total_segundos_1 = hora1.hora * 3600 + hora1.minuto * 60 + hora1.segundo
    total_segundos_2 = hora2.hora * 3600 + hora2.minuto * 60 + hora2.segundo
    diferencia = (total_segundos_2 - total_segundos_1).abs
    horas = diferencia / 3600
    minutos = (diferencia % 3600) / 60
    segundos = diferencia % 60
    "#{horas} horas, #{minutos} minutos, #{segundos} segundos"
  end

  # Método para obtener el nivel de atención según el tiempo transcurrido desde una hora de entrada
  def self.obtener_nivel(hora_entrada, hora_actual)
    total_segundos_entrada = hora_entrada.hora * 3600 + hora_entrada.minuto * 60 + hora_entrada.segundo
    total_segundos_actual = hora_actual.hora * 3600 + hora_actual.minuto * 60 + hora_actual.segundo
    diferencia_segundos = (total_segundos_actual - total_segundos_entrada).abs
    minutos = diferencia_segundos / 60
    case minutos
    when 0..6
      AZUL
    when 7..30
      ROJO
    when 31..45
      NARANJA
    when 46..60
      VERDE
    else
      NEGRO
    end
  end
  
  #Freeze sirve para evitar que se cambie el el valor por accidente 
  VERSION = '1.0.0'.freeze

  # Método para fusionar dos servicios de salud
  def self.fusionar_servicios(servicio1, servicio2)
    unless servicio1.is_a?(ServicioSalud) && servicio2.is_a?(ServicioSalud)
      raise ArgumentError, "Ambos argumentos deben ser instancias de ServicioSalud"
    end

    # Crear un nuevo servicio fusionado
    servicio_fusionado = ServicioSalud.new(
      codigo: "#{servicio1.codigo}-#{servicio2.codigo}",
      descripcion: "#{servicio1.descripcion} & #{servicio2.descripcion}",
      horario_apertura: [servicio1.horario_apertura, servicio2.horario_apertura].min,
      horario_cierre: [servicio1.horario_cierre, servicio2.horario_cierre].max,
      dias_festivos: (servicio1.dias_festivos + servicio2.dias_festivos).uniq,
      medicos: servicio1.medicos + servicio2.medicos,
      camas: servicio1.camas.merge(servicio2.camas) { |_, cama1, cama2| cama1 || cama2 }
    )

    servicio_fusionado
  end


  def self.calcular_indice_respuesta(servicio)
    # 1. Calcular el tiempo medio de ocupación (en minutos)
    tiempos_ocupacion = servicio.camas.values.map do |cama|
      if cama
        paciente = cama[:paciente]
        ingreso = cama[:ingreso]
        alta = ServicioSanitario::Hora.new(hora: 12, minuto: 0, segundo: 0) # Aquí puedes usar la hora actual
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

    # 2. Calcular el ratio de facultativos por paciente
    total_pacientes = servicio.pacientes_asignados
    total_medicos = servicio.medicos.size

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

    # 3. Calcular el índice de capacidad de respuesta como promedio de los dos puntajes
    indice_respuesta = (tiempo_puntaje + ratio_puntaje) / 2.0
    indice_respuesta.round
  end

  # Método para seleccionar el servicio con el mayor índice de capacidad de respuesta
  def self.seleccionar_mejor_servicio(*servicios)
    # Verificar que todos los argumentos sean instancias de ServicioSalud
    unless servicios.all? { |servicio| servicio.is_a?(ServicioSalud) }
      raise ArgumentError, "Todos los elementos deben ser instancias de ServicioSalud"
    end

    # Calcular el índice para cada servicio y seleccionar el mejor
    servicios.max_by { |servicio| calcular_indice_respuesta(servicio) }
  end

  def self.seleccionar_mejor_servicio_uci(servicios)
    # Filtrar servicios de urgencias que tienen camas UCI
    servicios_uci = servicios.select { |servicio| servicio.is_a?(Urgencias) && servicio.camas_uci > 0 }

    # Si no hay servicios con camas UCI, devolvemos nil o un mensaje adecuado
    return nil if servicios_uci.empty?

    # Seleccionar el servicio con el mayor índice de capacidad de respuesta
    mejor_servicio_uci = servicios_uci.max_by { |servicio| calcular_indice_respuesta(servicio) }

    # Devolver el servicio con el mayor índice de capacidad de respuesta
    mejor_servicio_uci
  end

  # Función única para calcular el porcentaje de camas libres de cada servicio
  def self.porcent_camas(servicios)
    servicios.each_with_object({}) do |servicio, resultados|
      total_camas = servicio.camas.size.to_f
      num_camas_libres = servicio.camas.count { |_, paciente| paciente.nil? }
      porcentaje_libres = (num_camas_libres / total_camas) * 100
      resultados[servicio.codigo] = porcentaje_libres.round
    end
  end 

  def self.porcent_especialidad(servicios)
    resultado = {}
  
    servicios.each do |servicio|
      next if servicio.nil?  # Ignoramos servicios nil
  
      especialidades = Hash.new(0)
  
      # Asegúrate de que el servicio tenga médicos antes de intentar recorrerlos
      if servicio.medicos.any?
        servicio.medicos.each do |medico|
          especialidades[medico.especialidad] += 1
        end
  
        total_medicos = servicio.medicos.size
        resultado[servicio.codigo] = {}  # Inicializamos el hash de resultados para cada servicio
  
        especialidades.each do |especialidad, cantidad|
          porcentaje = (cantidad.to_f / total_medicos) * 100
          resultado[servicio.codigo][especialidad] = porcentaje
        end
      else
        # Si no tiene médicos, asignamos un valor predeterminado (0% para todas las especialidades)
        resultado[servicio.codigo] = {"Ninguna" => 0}
      end
    end
  
    resultado
  end

  class Error < StandardError; end 
end
