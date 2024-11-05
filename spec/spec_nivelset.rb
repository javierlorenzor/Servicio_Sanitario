require 'spec_helper'
require 'ServicioSanitario/NivelSet'

RSpec.describe ServicioSanitario::NivelSet do
    it "Se espera que se asigne el nivel , categoría y tiempo correcto" do
        nivel_set = ServicioSanitario::NivelSet.new(:I, "Reanimacion", "Inmediato")
        expect(nivel_set.nivel).to eq(:I)
        expect(nivel_set.categoria).to eq("Reanimacion")
        expect(nivel_set.tiempo_atencion).to eq("Inmediato")
    end
end