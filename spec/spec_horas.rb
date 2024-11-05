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

end