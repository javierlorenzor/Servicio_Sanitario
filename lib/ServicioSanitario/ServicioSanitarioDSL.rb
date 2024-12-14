module ServicioSanitario
  class ServicioSanitarioDSL
    def initialize(&block)
      @servicios = []
      @usuarios = []
      @medicos = {}

      if block_given?
        if block.arity == 1
          yield self
        else
          instance_eval(&block)
        end
      end
    end

    def servicio(tipo, codigo:, descripcion:, horario_apertura:, horario_cierre:, dias_festivos: [], medicos: [], camas: {}, numero_plantas: nil)
      servicio = if tipo == :hospital
        Hospital.new(
          codigo: codigo, 
          descripcion: descripcion, 
          horario_apertura: horario_apertura,
          horario_cierre: horario_cierre, 
          dias_festivos: dias_festivos, 
          medicos:  medicos.map { |nombre| @medicos[nombre] },
          camas: camas, 
          numero_plantas: numero_plantas
        )
      else
        ServicioSalud.new(
          codigo: codigo, 
          descripcion: descripcion, 
          horario_apertura: horario_apertura,
          horario_cierre: horario_cierre, 
          dias_festivos: dias_festivos, 
          medicos:  medicos.map { |nombre| @medicos[nombre] },
          camas: camas
        )
      end
      @servicios << servicio
    end

    def usuario(tipo, numero_identificacion:, nombre:, apellido:, sexo:, fecha_nacimiento:, especialidad: nil, prioridad: nil)
      usuario = if tipo == :medico
                  medico = Medico.new(numero_identificacion, nombre , apellido, sexo, fecha_nacimiento, especialidad)
                  @medicos["#{nombre} #{apellido}"] = medico
                elsif tipo == :paciente
                  Paciente.new(numero_identificacion, nombre, apellido, sexo, fecha_nacimiento, prioridad)
                else
                  raise ArgumentError, "Tipo de usuario no reconocido: #{tipo}"
                end
      @usuarios << usuario
    end

    def to_s
      output = "Servicios:\n"
      output << @servicios.map(&:to_s).join("\n")
      output << "\nUsuarios:\n"
      
      @usuarios.each do |usuario|
        output << "#{usuario.to_s}\n"
      end
      
      output
    end

  end
end
  