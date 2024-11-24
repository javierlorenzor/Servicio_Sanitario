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

    context "Gestión de camas" do
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
    
        it "Se espera poder liberar una cama ocupada" do
           @servicio.asignar_cama(@paciente1)
           @servicio.liberar_cama(1)
           expect(@servicio.camas[1]).to be_nil
        end
        it "Se espera devolver el número correcto de camas libres cuando todas están disponibles" do
            expect(@servicio.numero_camas_libres).to eq(3)
        end
        
        it "Se espera devolver el número correcto de camas libres cuando una cama está ocupada" do
            @servicio.asignar_cama(@paciente1)
            expect(@servicio.numero_camas_libres).to eq(2)
        end

        it "Se espara devolver el número correcto de camas libres cuando dos camas están ocupadas" do
            @servicio.asignar_cama(@paciente1)
            @servicio.asignar_cama(@paciente2)
            expect(@servicio.numero_camas_libres).to eq(1)
        end
    
        it "Se espera devolver cero camas libres cuando todas están ocupadas" do
            @servicio.asignar_cama(@paciente1)
            @servicio.asignar_cama(@paciente2)
            @servicio.asignar_cama(ServicioSanitario::Persona.new("33333", "Juan", "Pérez", "M", @fecha1))
            expect(@servicio.numero_camas_libres).to eq(0)
        end
    
        it "Se espera devolevr el número correcto de camas libres después de liberar una cama" do
            cama_asignada = @servicio.asignar_cama(@paciente1)
            @servicio.liberar_cama(cama_asignada)
            expect(@servicio.numero_camas_libres).to eq(3)
        end
    end

    context "Asignar camas pacientes" do 
        it "Se espera no asignar un médico a un paciente correctamente si el médico tiene espacio" do
            @servicio.asignar_cama(@paciente1)
            @servicio.asignar_cama(@paciente2)
            expect(@servicio.asignar_medico(@medico1, @paciente1)).to eq(true)
            expect(@medico1.pacientes).to include(@paciente1)
        end
        
        it "Se espera no asignar un médico a un paciente si el médico ya tiene 10 pacientes asignados" do
            @servicio.asignar_cama(@paciente1)
            @servicio.asignar_cama(@paciente2)
            # Asignar 10 pacientes al médico
            9.times do |i|
                paciente = ServicioSanitario::Persona.new("1111#{i}", "Paciente#{i}", "Apellido#{i}", "M", @fecha1)
                @medico1.pacientes << paciente
            end
            # Intentar asignar el paciente3
            expect(@servicio.asignar_medico(@medico1, @paciente3)).to eq(false)
            expect(@medico1.pacientes).not_to include(@paciente3)
        end
        
    end 

    context "Numero de pacientes" do 
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

    end
    
    context "Ocupacion de la cama" do 
         
        it "calcula correctamente la duración de la ocupación de la cama en horas" do
            duracion = @servicio.duracion_ocupacion_cama(@paciente1)
            expect(duracion).to eq(5.0) # Duración de 5 horas
        end

        it "devuelve nil si no se encuentra la cama ocupada por el paciente" do
            paciente_no_asignado = ServicioSanitario::Persona.new("99999", "Ana", "González", "F", @fecha2)
            duracion = @servicio.duracion_ocupacion_cama(paciente_no_asignado)
            expect(duracion).to be_nil
        end
    end 



end 