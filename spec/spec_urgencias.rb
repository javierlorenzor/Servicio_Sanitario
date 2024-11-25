require 'spec_helper'
require 'ServicioSanitario/ServicioSalud'
require 'ServicioSanitario'
require 'ServicioSanitario/Urgencias'

RSpec.describe ServicioSanitario::Urgencias do

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
    
        # Configuración de camas para el servicio
        @camas = { 1 => nil, 2 => nil, 3 => nil }
    
        # Crear un servicio de urgencias
        @urgencias = ServicioSanitario::Urgencias.new(
          codigo: "URG001",
          descripcion: "Urgencias Generales",
          horario_apertura: @horario_apertura,
          horario_cierre: @horario_cierre,
          dias_festivos: [@dia_festivo1, @dia_festivo2],
          medicos: [@medico1, @medico2],
          camas: @camas,
          camas_uci: 5  # Asumimos que hay 5 camas UCI
        )
    end
    
    context "Inicialización y herencia " do
        it "Se espera poder crear una instancia de ServicioSalud" do
          expect(@urgencias).not_to be_nil
        end

        it "Se espera poder inicializar correctamente las propiedades del servicio de urgencias" do
            expect(@urgencias.codigo).to eq("URG001")
            expect(@urgencias.descripcion).to eq("Urgencias Generales")
            expect(@urgencias.horario_apertura).to eq(@horario_apertura)
            expect(@urgencias.horario_cierre).to eq(@horario_cierre)
            expect(@urgencias.dias_festivos).to include(@dia_festivo1, @dia_festivo2)
            expect(@urgencias.medicos).to include(@medico1, @medico2)
            expect(@urgencias.camas).to eq(@camas)
            expect(@urgencias.camas_uci).to eq(5)
          end

    end  

end 
