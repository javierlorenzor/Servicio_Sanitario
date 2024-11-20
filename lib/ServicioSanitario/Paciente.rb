require_relative 'Persona'
require_relative 'NivelSet'

# Módulo principal para la gema ServicioSanitario
module ServicioSanitario
  # Clase que representa a un paciente en el sistema sanitario.
  # Hereda de `Persona` e incluye atributos y métodos específicos para pacientes.
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
        
    def each(&block)
      # Iterar primero sobre la prioridad y luego sobre los diagnósticos
      yield @prioridad if block_given?
      @diagnosticos.each(&block)
    end

  end
end