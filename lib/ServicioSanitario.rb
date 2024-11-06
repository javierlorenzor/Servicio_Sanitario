# frozen_string_literal: true

# Requiere el archivo de versión de "ServicioSanitario"
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
  # @param fecha1 [Fecha] La primera fecha
  # @param fecha2 [Fecha] La segunda fecha
  # @return [String] La diferencia en años, meses y días
  def self.diferencia(fecha1, fecha2)
    # Obtener los valores de día, mes y año de cada objeto fecha
    dia1, mes1, anio1 = fecha1.dia, fecha1.mes, fecha1.anio
    dia2, mes2, anio2 = fecha2.dia, fecha2.mes, fecha2.anio

    # Calcular el total de días de cada fecha (simplificado: 365 días por año, 30 días por mes)
    total_dias_1 = anio1 * 365 + mes1 * 30 + dia1
    total_dias_2 = anio2 * 365 + mes2 * 30 + dia2

    # Calcular la diferencia total de días
    diferencia = (total_dias_2 - total_dias_1).abs
    # Convertir la diferencia en años, meses y días
    años = diferencia / 365
    meses = (diferencia % 365) / 30
    dias = (diferencia % 365) % 30

    # Devuelve el resultado en formato legible
    "#{años} años, #{meses} meses, #{dias} días"
  end

  # Método para calcular la diferencia en horas, minutos y segundos entre dos horas dadas
  # @param hora1 [Hora] La primera hora
  # @param hora2 [Hora] La segunda hora
  # @return [String] La diferencia en horas, minutos y segundos
  def self.diferencia_horas(hora1, hora2)
    # Convertir las horas, minutos y segundos a segundos totales
    total_segundos_1 = hora1.hora * 3600 + hora1.minuto * 60 + hora1.segundo
    total_segundos_2 = hora2.hora * 3600 + hora2.minuto * 60 + hora2.segundo
    # Calcular la diferencia en segundos
    diferencia = (total_segundos_2 - total_segundos_1).abs
    horas = diferencia / 3600
    minutos = (diferencia % 3600) / 60
    segundos = diferencia % 60
    # Devuelve el resultado en formato legible
    "#{horas} horas, #{minutos} minutos, #{segundos} segundos"
  end

  # Método para obtener el nivel de atención según el tiempo transcurrido desde una hora de entrada
  # @param hora_entrada [Hora] La hora de entrada del paciente
  # @param hora_actual [Hora] La hora actual
  # @return [Hash] El nivel de atención con su categoría y tiempo de atención
  def self.obtener_nivel(hora_entrada, hora_actual)
    # Convertir la hora de entrada y la hora actual en segundos desde medianoche
    total_segundos_entrada = hora_entrada.hora * 3600 + hora_entrada.minuto * 60 + hora_entrada.segundo
    total_segundos_actual = hora_actual.hora * 3600 + hora_actual.minuto * 60 + hora_actual.segundo
    # Calcular la diferencia en segundos
    diferencia_segundos = (total_segundos_actual - total_segundos_entrada).abs
    # Convertir la diferencia en minutos
    minutos = diferencia_segundos / 60

    # Determinar el nivel de atención según los minutos transcurridos
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
  
  # Definición de una clase Error personalizada que hereda de StandardError
  class Error < StandardError; end
  # Aquí finaliza el código del módulo
end
