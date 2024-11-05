# frozen_string_literal: true

require_relative "ServicioSanitario/version"

module ServicioSanitario
  AZUL = { nivel: :I, categoria: :Reanimacion, tiempo_atencion: :Inmediato }
  ROJO = { nivel: :II, categoria: :Emergencia, tiempo_atencion: '7 minutos' }
  NARANJA = { nivel: :III, categoria: :Urgente, tiempo_atencion: '30 minutos' }
  VERDE = { nivel: :IV, categoria: :Menos_urgente, tiempo_atencion: '45 minutos' }
  NEGRO = { nivel: :V, categoria: :No_urgente, tiempo_atencion: '60 minutos' }

  def self.obtener_nivel(tiempo_de_atencion)
    case tiempo_de_atencion
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



  
  class Error < StandardError; end
  # Your code goes here...
end
