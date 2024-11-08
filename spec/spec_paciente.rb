require 'spec_helper'
require 'ServicioSanitario/Persona'
require 'ServicioSanitario/NivelSet'
require 'ServicioSanitario/Paciente'
require 'ServicioSanitario'

# Descripción de las pruebas para la clase ServicioSanitario::Paciente
RSpec.describe ServicioSanitario::Paciente do
    before(:each) do
        @fecha1 = ServicioSanitario::Fecha.new(dia: 19, mes: 7, anio: 2001)
        @fecha2 = ServicioSanitario::Fecha.new(dia: 23, mes: 9, anio: 2004)
        @paciente1 = ServicioSanitario::Paciente.new("12345", "Juan", "Pérez", "M", @fecha1, "Alta")
        @paciente2 = ServicioSanitario::Paciente.new("67890", "Ana", "García", "F", @fecha2, "Urgente")
    end
    it "Se espera que se pueda inicializar persona correctamente con valores válidos" do
        expect(@paciente1).not_to be_nil
        expect(@paciente2).not_to be_nil
    end

end