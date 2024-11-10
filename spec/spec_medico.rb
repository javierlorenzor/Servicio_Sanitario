require 'spec_helper'
require 'ServicioSanitario/Medico'
require 'ServicioSanitario/NivelSet'
require 'ServicioSanitario/Persona'
require 'ServicioSanitario'

# Descripción de las pruebas para la clase ServicioSanitario::Medico
RSpec.describe ServicioSanitario::Medico do

    before(:each) do
        @fecha1 = ServicioSanitario::Fecha.new(dia: 10, mes: 5, anio: 1980)
        @medico1 = ServicioSanitario::Medico.new("12345", "Alba", "Perez", "F", @fecha1, "Pediatría")
        @fecha2 = ServicioSanitario::Fecha.new(dia: 10, mes: 5, anio: 1980)
        @medico2 = ServicioSanitario::Medico.new("56789", "Miguel", "Tadeo", "M", @fecha2, "Pediatría")
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

    it "Se debe inicializar con los atributos correctos" do
        expect(@medico2.numero_identificacion).to eq("56789")
        expect(@medico2.nombre).to eq("Miguel")
        expect(@medico2.apellido).to eq("Tadeo")
        expect(@medico2.sexo).to eq("M")
        expect(@medico2.fecha_nacimiento).to eq(@fecha2)
        expect(@medico2.especialidad).to eq("Pediatría")
        expect(@medico2.pacientes).to be_empty
      end


end 
