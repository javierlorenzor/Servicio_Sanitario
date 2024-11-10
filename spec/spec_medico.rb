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

    it "Se espera que la instancia pertenezca a a la clase determinada" do
        # Comprobamos que el método to_s devuelva el formato correcto
        expect(@medico1).to be_a(ServicioSanitario::Medico)
        expect(@medico2).to be_a(ServicioSanitario::Medico)
        expect(@medico1.instance_of?(ServicioSanitario::Medico)).to be true
        expect(ServicioSanitario::Medico.superclass).to eq(ServicioSanitario::Persona)
    end


end 
