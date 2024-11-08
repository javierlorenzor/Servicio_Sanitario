require 'spec_helper'
require 'ServicioSanitario/Persona'
require 'ServicioSanitario/Fecha'
require 'ServicioSanitario'

# Descripción de las pruebas para la clase ServicioSanitario::Fecha
RSpec.describe ServicioSanitario::Persona do
    before(:each) do
        @fecha1 = ServicioSanitario::Fecha.new(dia: 19, mes: 7, anio: 2001)
        @fecha2 = ServicioSanitario::Fecha.new(dia: 23, mes: 9, anio: 2001)
        @persona1 = ServicioSanitario::Persona.new("12345", "Juan", "Pérez", "M", @fecha1)
        @persona2 = ServicioSanitario::Persona.new("67890", "Ana", "García", "F", @fecha2)
    end
    it "S espera que se pueda inicializar persona correctamente con valores válidos" do
        expect(@persona1).not_to be_nil
        expect(@persona2).not_to be_nil
    end
end