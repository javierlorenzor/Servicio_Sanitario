require 'spec_helper'
require 'ServicioSanitario/Fecha'

RSpec.describe ServicioSanitario::Fecha do

    before(:each) do
        @fecha = ServicioSanitario::Fecha.new(dia: 15, mes: 11, anio: 2024)
    end

    it "Se espera poder crear una instancia de Fecha" do
        expect(@fecha).not_to be_nil
    end

    it "Se espera poder acceder a los atributos de la fecha (getters)" do
        expect(@fecha.dia).to eq(15)
        expect(@fecha.mes).to eq(11)
        expect(@fecha.anio).to eq(2024)
    end
    it "Se espera poder representar la fecha como cadena de manera correcta" do
        expect(@fecha.to_s).to eq("15/11/2024")
    end
end