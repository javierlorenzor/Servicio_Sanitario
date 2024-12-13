module ServicioSanitario
    class ServicioSanitarioDSL
      def self.iniciar_sistema
        @servicios = []
        @usuarios = []
      end
  
      def self.registrar_servicio(tipo:, codigo:, descripcion:, horario_apertura:, horario_cierre:, dias_festivos: [], medicos: [], camas: {}, numero_plantas: nil)
        servicio = if tipo == :hospital
                     Hospital.new(codigo: codigo, descripcion: descripcion, horario_apertura: horario_apertura,
                                  horario_cierre: horario_cierre, dias_festivos: dias_festivos, medicos: medicos,
                                  camas: camas, numero_plantas: numero_plantas)
                   else
                     ServicioSalud.new(codigo: codigo, descripcion: descripcion, horario_apertura: horario_apertura,
                                       horario_cierre: horario_cierre, dias_festivos: dias_festivos, medicos: medicos, camas: camas)
                   end
        @servicios << servicio
      end
  
      def self.registrar_usuario(tipo:, numero_identificacion:, nombre:, apellido:, sexo:, fecha_nacimiento:, especialidad: nil, prioridad: nil)
        usuario = if tipo == :medico
                    Medico.new(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento, especialidad)
                  elsif tipo == :paciente
                    Paciente.new(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento, prioridad)
                  else
                    raise ArgumentError, "Tipo de usuario no reconocido: #{tipo}"
                  end
        @usuarios << usuario
      end
  
      def self.asignar_medico_a_paciente(medico_id, paciente_id)
        medico = @usuarios.find { |u| u.is_a?(Medico) && u.numero_identificacion == medico_id }
        paciente = @usuarios.find { |u| u.is_a?(Paciente) && u.numero_identificacion == paciente_id }
  
        if medico && paciente
          medico.pacientes << paciente
          "Medico #{medico.nombre_completo} asignado al paciente #{paciente.nombre_completo}"
        else
          "No se pudo asignar: Médico o Paciente no encontrado."
        end
      end
  
      def self.solicitar_servicio(servicio_codigo, paciente_id)
        servicio = @servicios.find { |s| s.codigo == servicio_codigo }
        paciente = @usuarios.find { |u| u.is_a?(Paciente) && u.numero_identificacion == paciente_id }
  
        if servicio && paciente
          cama_asignada = servicio.asignar_cama(paciente)
          if cama_asignada
            "Paciente #{paciente.nombre_completo} asignado a la cama #{cama_asignada} en el servicio #{servicio.descripcion}"
          else
            "No hay camas disponibles en el servicio #{servicio.descripcion}"
          end
        else
          "Servicio o Paciente no encontrado."
        end
      end
  
      def self.estado_sistema
        "Servicios:\n" + @servicios.map(&:to_s).join("\n") + "\nUsuarios:\n" + @usuarios.map(&:to_s).join("\n")
      end
  
      iniciar_sistema
    end
end
  