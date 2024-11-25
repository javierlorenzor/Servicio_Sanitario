require 'spec_helper'
require 'ServicioSanitario/ServicioSalud'
require 'ServicioSanitario'
require 'ServicioSanitario/Hospital'

RSpec.describe ServicioSanitario::Hospital do

    context "Inicialización de atributos , to_s y herencia" do
        it "Se espera poder crear una instancia de ServicioSalud" do
          expect(ServicioSanitario::Hospital).not_to be_nil
        end
    end 
end 