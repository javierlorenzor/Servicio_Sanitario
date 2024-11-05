# frozen_string_literal: true

require_relative "ServicioSanitario/version"

module ServicioSanitario
  AZUL = { nivel: :I, categoria: :Reanimacion, tiempo_atencion: :Inmediato }
  ROJO = { nivel: :II, categoria: :Emergencia, tiempo_atencion: '7 minutos' }
  NARANJA = { nivel: :III, categoria: :Urgente, tiempo_atencion: '30 minutos' }
  VERDE = { nivel: :IV, categoria: :Menos_urgente, tiempo_atencion: '45 minutos' }
  NEGRO = { nivel: :V, categoria: :No_urgente, tiempo_atencion: '60 minutos' }
  
  def self.diferencia(fecha1, fecha2)
    # Obtener directamente los atributos de los objetos pasados
    dia1, mes1, anio1 = fecha1.dia, fecha1.mes, fecha1.anio
    dia2, mes2, anio2 = fecha2.dia, fecha2.mes, fecha2.anio

    # Calcular los días totales
    total_dias_1 = anio1 * 365 + mes1 * 30 + dia1
    total_dias_2 = anio2 * 365 + mes2 * 30 + dia2

    diferencia = (total_dias_2 - total_dias_1).abs
    años = diferencia / 365
    meses = (diferencia % 365) / 30
    dias = (diferencia % 365) % 30

    "#{años} años, #{meses} meses, #{dias} días"
  end

  def self.diferencia_horas(hora1, hora2)
    total_segundos_1 = hora1.hora * 3600 + hora1.minuto * 60 + hora1.segundo
    total_segundos_2 = hora2.hora * 3600 + hora2.minuto * 60 + hora2.segundo
    diferencia = (total_segundos_2 - total_segundos_1).abs
    horas = diferencia / 3600
    minutos = (diferencia % 3600) / 60
    segundos = diferencia % 60
    "#{horas} horas, #{minutos} minutos, #{segundos} segundos"
  end

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
  
  class Error < StandardError; end
  # Your code goes here...
end
