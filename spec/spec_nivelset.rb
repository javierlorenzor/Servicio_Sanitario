require 'spec_helper'
require 'ServicioSanitario/NivelSet'

RSpec.describe ServicioSanitario::NivelSet do
    before(:each) do
        # Crear la instancia de NivelSet antes de cada prueba
        @nivel1 = ServicioSanitario::NivelSet.new(:I, 'Reanimacion', 'Inmediato')
    end

    it "Se espera poder crear una instancia de NivelSet" do
        expect(@nivel1).not_to be_nil
    end

    it "Se espera que se pueda obtener el valor correcto de nivel" do
        @nivel1 = ServicioSanitario::NivelSet.new(:I, 'Reanimacion', 'Inmediato')
        expect(@nivel1.nivel).to eq(:I)
        expect(@nivel1.categoria).to eq('Reanimacion')
        expect(@nivel1.tiempo_atencion).to eq('Inmediato')
    end
    it "Se espera poder devolver la representación en cadena de manera correcta" do
        expect(@nivel1.to_s).to eq("Nivel: I, Categoría: Reanimacion, Tiempo de atención: Inmediato")
    end
end