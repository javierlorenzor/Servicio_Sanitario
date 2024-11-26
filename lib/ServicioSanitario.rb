# frozen_string_literal: true
require_relative "ServicioSanitario/version"

# El módulo ServicioSanitario define diferentes constantes y métodos relacionados con la atención médica.
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


  class Error < StandardError; end

  
end
