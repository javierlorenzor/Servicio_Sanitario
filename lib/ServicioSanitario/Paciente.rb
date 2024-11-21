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
      # Compara primero por la prioridad (usando la prioridad[:nivel])
      prioridad_comparacion = self.prioridad[:nivel] <=> other.prioridad[:nivel]
      return prioridad_comparacion unless prioridad_comparacion == 0
  
      # Si la prioridad es la misma, compara por tiempo de atención
      other.tiempo_atencion <=>  self.tiempo_atencion 
    end
  
    def tiempo_atencion
      # Usamos el valor de 'tiempo_atencion' dentro del hash de prioridad
      parse_tiempo(prioridad[:tiempo_atencion])
    end
  
    # Método para convertir el tiempo de atención a un valor numérico
    def parse_tiempo(tiempo)
      tiempo = tiempo.to_s.downcase.strip  # Convertimos a cadena antes de procesar
      return 0 if tiempo == 'inmediato'
    
      # Si el tiempo tiene una unidad en minutos, extraemos el número
      tiempo.scan(/\d+/).first.to_i
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