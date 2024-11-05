require 'spec_helper'
require 'ServicioSanitario/Fecha'

RSpec.describe ServicioSanitario::Fecha do
    
    before(:each) do
        @fecha = ServicioSanitario::Fecha.new(dia: 15, mes: 11, anio: 2024)
    end

    it "Se espera poder crear una instancia de Fecha" do
        expect(@fecha).not_to be_nil
    end
end