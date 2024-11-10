require 'spec_helper'
require 'ServicioSanitario/Medico'
require 'ServicioSanitario/NivelSet'
require 'ServicioSanitario/Persona'
require 'ServicioSanitario'

# Descripción de las pruebas para la clase ServicioSanitario::Medico
RSpec.describe ServicioSanitario::Medico do

    before(:each) do
        @fecha1 = ServicioSanitario::Fecha.new(dia: 10, mes: 5, anio: 1980)
        @medico1 = ServicioSanitario::Medico.new("12345", "Alba", "Perez", "M", @fecha1, "Pediatría")
        @fecha2 = ServicioSanitario::Fecha.new(dia: 10, mes: 5, anio: 1980)
        @medico2 = ServicioSanitario::Medico.new("12345", "Miguel", "Tadeo", "M", @fecha2, "Pediatría")
    end

    it "Se espera que se pueda inicializar persona correctamente con valores válidos" do
        expect(@medico1).not_to be_nil
        expect(@medico2).not_to be_nil
    end


end 
