require_relative 'Persona'
require_relative 'NivelSet'


module ServicioSanitario

  class Paciente < Persona

    attr_accessor :prioridad, :diagnosticos

    def initialize(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento, prioridad)
      super(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento)
      @prioridad = prioridad
      @diagnosticos = []
    end


    def ultimo_diagnostico
      diagnosticos.last
    end

    def to_s
      "#{nombre_completo}, ID: #{@numero_identificacion}, Sexo: #{@sexo}, Fecha de Nacimiento: #{obtener_fecha}, Prioridad: #{prioridad}, Diagnósticos: #{diagnosticos.join(', ')}"
    end

    def <=>(other)
      # Primero, manejamos el caso especial de la prioridad "Inmediato"
      if prioridad[:tiempo_atencion] == :Inmediato && other.prioridad[:tiempo_atencion] != :Inmediato
        return -1
      elsif other.prioridad[:tiempo_atencion] == :Inmediato && prioridad[:tiempo_atencion] != :Inmediato
        return 1
      end
    
      # Si ambos tienen la misma prioridad (incluyendo :Inmediato), los comparamos normalmente
      if prioridad[:tiempo_atencion] == other.prioridad[:tiempo_atencion]
        return 0
      end
    
      # Convertir tiempos de atención para comparación (sin :Inmediato)
      tiempo_self = prioridad[:tiempo_atencion] == :Inmediato ? 0 : prioridad[:tiempo_atencion].to_s.split.first.to_i
      tiempo_other = other.prioridad[:tiempo_atencion] == :Inmediato ? 0 : other.prioridad[:tiempo_atencion].to_s.split.first.to_i
    
      # Comparar los tiempos
      tiempo_self <=> tiempo_other
    end
        
    def each
      yield @numero_identificacion
      yield nombre_completo
      yield @sexo
      yield obtener_fecha
      yield @prioridad
      diagnosticos.each { |diagnostico| yield diagnostico }
    end

  end
end