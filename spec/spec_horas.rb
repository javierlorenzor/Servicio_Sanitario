require 'spec_helper'
require 'ServicioSanitario/Horas'
require 'ServicioSanitario'

RSpec.describe ServicioSanitario::Hora do
    before(:each) do
        @hora = ServicioSanitario::Hora.new(hora: 12, minuto: 30, segundo: 45)
    end
    
    it "Se espera poder crear una instancia de Hora" do
        expect(@hora).not_to be_nil
    end
    
    it "Se espera que se pueda acceder a la hora , minutos y segundos correctamente" do
        expect(@hora.hora).to eq(12)
        expect(@hora.minuto).to eq(30)
        expect(@hora.segundo).to eq(45)
    end

end