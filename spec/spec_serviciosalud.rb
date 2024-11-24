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

    context "Inicialización y atributos" do
        it "Se espera poder crear una instancia de ServicioSalud" do
          expect(@servicio).not_to be_nil
        end
    end 
end 