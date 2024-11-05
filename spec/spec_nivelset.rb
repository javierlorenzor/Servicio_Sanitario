require 'spec_helper'
require 'ServicioSanitario/NivelSet'

RSpec.describe ServicioSanitario::NivelSet do

    it "Se espera poder crear una instancia de NivelSet" do
        nivel_set = ServicioSanitario::NivelSet.new(:I, 'Reanimacion', 'Inmediato')
        expect(nivel_set).not_to be_nil
    end

    it "Se espera que se pueda obtener el valor correcto de nivel" do
        nivel_set = ServicioSanitario::NivelSet.new(:I, 'Reanimacion', 'Inmediato')
        expect(nivel_set.nivel).to eq(:I)
        expect(nivel_set.categoria).to eq('Reanimacion')
        expect(nivel_set.tiempo_atencion).to eq('Inmediato')
    end
    it "Se espera poder devolver la representación en cadena de manera correcta" do
        expect(nivel_set.to_s).to eq("Nivel: I, Categoría: Reanimacion, Tiempo de atención: Inmediato")
    end
end