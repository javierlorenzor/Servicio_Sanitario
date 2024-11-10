require 'spec_helper'
require 'ServicioSanitario/Titular'
require 'ServicioSanitario/NivelSet'
require 'ServicioSanitario/Persona'
require 'ServicioSanitario/Paciente'
require 'ServicioSanitario/Medico'
require 'ServicioSanitario'

# Descripción de las pruebas para la clase ServicioSanitario::Medico
RSpec.describe ServicioSanitario::Titular do
    before(:each) do
        # Creación de fechas
        @fecha1 = ServicioSanitario::Fecha.new(dia: 10, mes: 5, anio: 1980)
        @fecha2 = ServicioSanitario::Fecha.new(dia: 20, mes: 6, anio: 1990)
    
        # Creación de médicos y pacientes
        @titular1 = ServicioSanitario::Titular.new("12345", "Alba", "Perez", "F", @fecha1, "Pediatría", 5)
        @titular2 = ServicioSanitario::Titular.new("56789", "Miguel", "Tadeo", "M", @fecha2, "Geriatría", 3)
    
        @paciente1 = ServicioSanitario::Paciente.new("54321", "Maria", "Gomez", "F", @fecha1, "Rojo")
        @paciente2 = ServicioSanitario::Paciente.new("67890", "Carlos", "Ruiz", "M", @fecha2, "Azul")
    end

    it "Se espera que se pueda inicializar persona correctamente con valores válidos" do
        expect(@titular1).not_to be_nil
        expect(@titular2).not_to be_nil
    end

end 
