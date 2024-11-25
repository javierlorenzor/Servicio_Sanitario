require 'spec_helper'
require 'ServicioSanitario/ServicioSalud'
require 'ServicioSanitario/Fecha'
require 'ServicioSanitario/Paciente'
require 'ServicioSanitario/Horas'
require 'ServicioSanitario/Persona'
require 'ServicioSanitario/Medico'

RSpec.describe ServicioSanitario::ServicioSalud do
    before(:each) do

        # Instancias de Fecha
        @fecha1 = ServicioSanitario::Fecha.new(dia: 19, mes: 7, anio: 2001)
        @fecha2 = ServicioSanitario::Fecha.new(dia: 23, mes: 9, anio: 2004)
        @dia_festivo1 = ServicioSanitario::Fecha.new(dia: 25, mes: 12, anio: 2024)
        @dia_festivo2 = ServicioSanitario::Fecha.new(dia: 1, mes: 1, anio: 2025)
    
        # Instancias de Hora
        @horario_apertura = ServicioSanitario::Hora.new(hora: 8, minuto: 0, segundo: 0)
        @horario_cierre = ServicioSanitario::Hora.new(hora: 20, minuto: 0, segundo: 0)
        @hora2 = ServicioSanitario::Hora.new(hora: 10, minuto: 40, segundo: 25)
        @hora3 = ServicioSanitario::Hora.new(hora: 14, minuto: 50, segundo: 15)
    
        # Instancias de Persona y Médico
        @paciente1 = ServicioSanitario::Persona.new("11111", "Carlos", "López", "M", @fecha1)
        @paciente2 = ServicioSanitario::Persona.new("22222", "Lucía", "Martínez", "F", @fecha2)
    
        @medico1 = ServicioSanitario::Medico.new("33333", "Alba", "Perez", "F", @fecha1, "Pediatría")
        @medico2 = ServicioSanitario::Medico.new("44444", "Miguel", "Tadeo", "M", @fecha2, "Pediatría")
    
        # Asignación de paciente a médico
        @medico2.pacientes << @paciente1
    
        # Configuración de camas y servicio
        @camas = { 1 => nil, 2 => nil, 3 => nil }
    
        @servicio = ServicioSanitario::ServicioSalud.new(
          codigo: "SAL001",
          descripcion: "Servicio de Salud General",
          horario_apertura: @horario_apertura,
          horario_cierre: @horario_cierre,
          dias_festivos: [@dia_festivo1, @dia_festivo2],
          medicos: [@medico1, @medico2],
          camas: @camas
        )
      
    end

    context "Inicialización de atributos y herencia" do
        it "Se espera poder crear una instancia de ServicioSalud" do
          expect(@servicio).not_to be_nil
        end

        it "Inicializa correctamente los atributos" do
            expect(@servicio.codigo).to eq("SAL001")
            expect(@servicio.descripcion).to eq("Servicio de Salud General")
            expect(@servicio.horario_apertura).to eq(@horario_apertura)
            expect(@servicio.horario_cierre).to eq(@horario_cierre)
            expect(@servicio.dias_festivos).to eq([@dia_festivo1, @dia_festivo2])
            expect(@servicio.medicos).to eq([@medico1, @medico2])
            expect(@servicio.camas).to eq(@camas)
        end
        it "Se espera que la instancia pertenezca a la clase determinada" do
            expect(@servicio).to be_a(ServicioSanitario::ServicioSalud)
            expect(@servicio).to be_a(Object)
            expect(@servicio.instance_of?(ServicioSanitario::ServicioSalud)).to be true
            expect(ServicioSanitario::ServicioSalud.superclass).to eq(Object)
            expect(Object.superclass).to eq(BasicObject)
        end
    end 

    context "Gestión de camas (asignar , liberar y num camas)" do
        
        it "Se espera poder asignar un paciente a una cama disponible" do
            cama_asignada = @servicio.asignar_cama(@paciente1)
            expect(@servicio.camas[cama_asignada][:paciente]).to eq(@paciente1)
            expect(@servicio.camas[cama_asignada][:ingreso]).not_to be_nil
        end
    
        it "Se espera no poder asignar una cama si no hay disponibilidad" do
          @servicio.asignar_cama(@paciente1)
          @servicio.asignar_cama(@paciente2)
          extra_paciente = ServicioSanitario::Persona.new("55555", "Pedro", "Gómez", "M", @fecha1)
          expect(@servicio.asignar_cama(extra_paciente)).to eq(3) # Última cama disponible
          expect(@servicio.asignar_cama(ServicioSanitario::Persona.new("66666", "Laura", "Díaz", "F", @fecha2))).to eq(nil)
        end

        it "Se espera marcar la cama como ocupada tras asignación" do
            @servicio.asignar_cama(@paciente1)
            expect(@servicio.camas[1]).not_to be_nil
        end
        
        it "Se espera poder liberar una cama ocupada" do
           @servicio.asignar_cama(@paciente1)
           @servicio.liberar_cama(1)
           expect(@servicio.camas[1]).to be_nil
        end

        it "Se espera devolver el número correcto de camas libres cuando todas están disponibles" do
            expect(@servicio.num_camas_libres).to eq(3)
        end
        
        it "Se espera devolver el número correcto de camas libres cuando una cama está ocupada" do
            @servicio.asignar_cama(@paciente1)
            expect(@servicio.num_camas_libres).to eq(2)
        end

        it "Se espara devolver el número correcto de camas libres cuando dos camas están ocupadas" do
            @servicio.asignar_cama(@paciente1)
            @servicio.asignar_cama(@paciente2)
            expect(@servicio.num_camas_libres).to eq(1)
        end
    
        it "Se espera devolver cero camas libres cuando todas están ocupadas" do
            @servicio.asignar_cama(@paciente1)
            @servicio.asignar_cama(@paciente2)
            @servicio.asignar_cama(ServicioSanitario::Persona.new("33333", "Juan", "Pérez", "M", @fecha1))
            expect(@servicio.num_camas_libres).to eq(0)
        end
    
        it "Se espera devolevr el número correcto de camas libres después de liberar una cama" do
            cama_asignada = @servicio.asignar_cama(@paciente1)
            @servicio.liberar_cama(cama_asignada)
            expect(@servicio.num_camas_libres).to eq(3)
        end

        it "Se espera almacenar correctamente la información del paciente y el tiempo de ingreso" do
            @servicio.asignar_cama(@paciente1)
            expect(@servicio.camas[1][:paciente]).to eq(@paciente1)
        end

        it "Se espera marcar la cama como libre tras ser liberada" do
            @servicio.asignar_cama(@paciente1)
            @servicio.liberar_cama(1)
            expect(@servicio.camas[1]).to be_nil
        end

        it "Se espera devuelver false si la cama no existe" do
            expect(@servicio.liberar_cama(99)).to be false
        end

        it "Se espera devolver true incluso si la cama ya está libre" do
            expect(@servicio.liberar_cama(1)).to be true
        end

        it "Se espera devolver el número correcto de camas libres" do
            expect(@servicio.num_camas_libres).to eq(3)
          end
      
        it "Se espera actualizar el número de camas libres tras asignar una cama" do
            @servicio.asignar_cama(@paciente1)
            expect(@servicio.num_camas_libres).to eq(2)
        end
      
        it "Se espera devolver 0 si no hay camas libres" do
            @servicio.camas.keys.each { |key| @servicio.camas[key] = { paciente: @paciente2, ingreso: Time.now } }
            expect(@servicio.num_camas_libres).to eq(0)
        end
      
        it "Se espera devolver el número correcto tras liberar una cama" do
            @servicio.asignar_cama(@paciente1)
            @servicio.liberar_cama(1)
            expect(@servicio.num_camas_libres).to eq(3)
        end

    end

    context "Asignar medicos a pacientes" do 

        it "Se espera que se asigne un médico a un paciente correctamente" do
            @servicio.asignar_cama(@paciente2)
            expect(@servicio.asignar_medico(@medico1, @paciente2)).to be true
        end

        it "Se espera no asignar un médico a un paciente correctamente si el médico tiene espacio" do
            @servicio.asignar_cama(@paciente1)
            @servicio.asignar_cama(@paciente2)
            expect(@servicio.asignar_medico(@medico1, @paciente1)).to eq(true)
            expect(@medico1.pacientes).to include(@paciente1)
        end

        it "Se espera añadir el paciente a la lista de pacientes del médico" do
            @servicio.asignar_cama(@paciente2)
            @servicio.asignar_medico(@medico1, @paciente2)
            expect(@medico1.pacientes).to include(@paciente2)
        end

        it "Se espera no asignar un médico a un paciente si el médico ya tiene 10 pacientes asignados" do
            @servicio.asignar_cama(@paciente1)
            @servicio.asignar_cama(@paciente2)
            10.times { @medico1.pacientes << @paciente2 }
            expect(@servicio.asignar_medico(@medico1, @paciente1)).to be false
        end

        it "Se espera devolver false si el paciente no está asignado a ninguna cama" do
            expect(@servicio.asignar_medico(@medico1, @paciente2)).to be false
        end

        it "Se espera devolver el número total de pacientes asignados a los médicos" do
            expect(@servicio.pacientes_asignados).to eq(1)
        end
        
        it "Se espera devolver 0 si no hay pacientes asignados a médicos" do
            # Limpiar los pacientes asignados a los médicos
            @medico1.pacientes.clear
            @medico2.pacientes.clear
            expect(@servicio.pacientes_asignados).to eq(0)
        end
        
        it "Se espera devolver el número correcto de pacientes cuando hay múltiples médicos" do
            # Asignar más pacientes a los médicos
            paciente4 = ServicioSanitario::Persona.new("44444", "María", "García", "F", @fecha2)
            paciente5 = ServicioSanitario::Persona.new("55555", "Pedro", "López", "M", @fecha1)
            @medico1.pacientes << paciente4
            @medico2.pacientes << paciente5
        
            expect(@servicio.pacientes_asignados).to eq(3)
        end

        it "Se espera no contar pacientes no asignados a ningún médico" do
            expect(@servicio.pacientes_asignados).to eq(1)
        end
    end 

 
    context "Ocupacion de la cama" do 
     
        it 'Se espera que la cama esté correctamente configurada antes de calcular la ocupación' do
            @servicio.asignar_cama(@paciente1) # Asignar al paciente1 a una cama antes de verificar
            cama = @servicio.camas[1] # Cama que debería estar asignada
            expect(cama[:paciente]).to eq(@paciente1)
            expect(cama[:ingreso]).not_to be_nil
        end

        it 'Se espera que devuelva nil si el paciente no tiene cama asignada' do
            duracion = @servicio.ocupacion_cama(@paciente2) # Paciente sin cama
            expect(duracion).to be_nil
        end

        it 'Se espera que devuelva nil si no se encuentra información de ingreso' do
            @servicio.asignar_cama(@paciente1) # Asigna sin especificar ingreso
            @servicio.camas[1][:ingreso] = nil # Forzar falta de información
            duracion = @servicio.ocupacion_cama(@paciente1)
            expect(duracion).to be_nil
        end

        # it 'calcula correctamente la duración de ocupación en horas' do
        #     ingreso = Time.now - 3600 # Hace 1 hora
        #     @servicio.asignar_cama(@paciente1, ingreso: ingreso) # Asigna al paciente1
        #     duracion = @servicio.ocupacion_cama(@paciente1)
        #     expect(duracion).to be_within(0.01).of(1.00) # Aproximadamente 1 hora
        #   end
      

      
        #   it 'calcula correctamente la duración con una fecha de alta personalizada' do
        #     ingreso = Time.now - 7200 # Hace 2 horas
        #     alta = Time.now - 3600    # Hace 1 hora
        #     @servicio.asignar_cama(@paciente1, ingreso: ingreso ) # Asigna al paciente1
        #     duracion = @servicio.ocupacion_cama(@paciente1, alta: alta)
        #     expect(duracion).to be_within(0.01).of(1.00) # Diferencia de 1 hora entre ingreso y alta
        #   end
      

          
    end 

    context "Metodo to_s" do 
        it "Se espera devolver una representación en cadena del servicio de salud correctamente" do
            expected_output = <<~INFO
              Código: SAL001
              Descripción: Servicio de Salud General
              Horario: #{@horario_apertura} - #{@horario_cierre}
              Días Festivos: #{@dia_festivo1.to_s}, #{@dia_festivo2.to_s}
              Camas Libres: 3
              Total de Pacientes Asignados a Médicos: 1
            INFO
            expect(@servicio.to_s).to eq(expected_output)
        end
    end 

    context "Modulo COMPARABLE" do 
    end 

end 