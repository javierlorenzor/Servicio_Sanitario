require 'spec_helper'
require 'ServicioSanitario/Persona'
require 'ServicioSanitario/Fecha'
require 'ServicioSanitario'

# Descripción de las pruebas para la clase ServicioSanitario::Fecha
RSpec.describe ServicioSanitario::Persona do
    before(:each) do
        @fecha1 = ServicioSanitario::Fecha.new(dia: 19, mes: 7, anio: 2001)
        @fecha2 = ServicioSanitario::Fecha.new(dia: 23, mes: 9, anio: 2004)
        @fecha3=ServicioSanitario::Fecha.new(dia:15 , mes: 11, anio: 2024)
        @persona1 = ServicioSanitario::Persona.new("12345", "Juan", "Pérez", "M", @fecha1)
        @persona2 = ServicioSanitario::Persona.new("67890", "Ana", "García", "F", @fecha2)
    end
    it "Se espera que se pueda inicializar persona correctamente con valores válidos" do
        expect(@persona1).not_to be_nil
        expect(@persona2).not_to be_nil
    end
    it "Se espera que la instancia pertenezca a a la clase determinada" do
        expect(@persona1).to be_a(ServicioSanitario::Persona)
        expect(@persona2).to be_a(ServicioSanitario::Persona)
        expect(@persona1.instance_of?(ServicioSanitario::Persona)).to be true
        expect(ServicioSanitario::Fecha.superclass).to eq(Object)
    end

    it "Se espera que se devuelve una cadena con la información completa de la persona " do
        expect(@persona1.to_s).to eq("Juan Pérez, ID: 12345, Sexo: M, Fecha de Nacimiento: 19/7/2001")
        expect(@persona2.to_s).to eq("Ana García, ID: 67890, Sexo: F, Fecha de Nacimiento: 23/9/2004")
    end

    it "Se espera que se incrementa el contador cada vez que se crea una nueva instancia" do
        expect(ServicioSanitario::Persona.contador_instancias).to eq(8)  
        persona3 = ServicioSanitario::Persona.new("54321", "Carlos", "López", "M", "12/11/2005")
        expect(ServicioSanitario::Persona.contador_instancias).to eq(9)
    end

    it 'Se espera poder calcular correctamente la edad de la persona' do
        expect(@persona1.edad(@fecha3)).to eq(23)  
        expect(@persona2.edad(@fecha3)).to eq(20)  
    end
  
end