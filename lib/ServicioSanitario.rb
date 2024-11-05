# frozen_string_literal: true

require_relative "ServicioSanitario/version"

module ServicioSanitario
  AZUL = { nivel: :I, categoria: :Reanimacion, tiempo_atencion: :Inmediato }
  ROJO = { nivel: :II, categoria: :Emergencia, tiempo_atencion: '7 minutos' }
  NARANJA = { nivel: :III, categoria: :Urgente, tiempo_atencion: '30 minutos' }
  VERDE = { nivel: :IV, categoria: :Menos_urgente, tiempo_atencion: '45 minutos' }
  NEGRO = { nivel: :V, categoria: :No_urgente, tiempo_atencion: '60 minutos' }
  
  class Error < StandardError; end
  # Your code goes here...
end
