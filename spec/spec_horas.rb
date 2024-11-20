require 'spec_helper'
require 'ServicioSanitario/Horas'
require 'ServicioSanitario'

# Descripción de las pruebas para la clase ServicioSanitario::Hora
RSpec.describe ServicioSanitario::Hora do
  # Se ejecuta antes de cada prueba para inicializar las instancias necesarias de Hora
  before(:each) do
    # Creación de dos instancias de la clase Hora con los mismos valores de hora, minuto y segundo
    @hora = ServicioSanitario::Hora.new(hora: 12, minuto: 30, segundo: 45)
    @hora1 = ServicioSanitario::Hora.new(hora: 12, minuto: 30, segundo: 45)
    @hora2 = ServicioSanitario::Hora.new(hora: 10, minuto: 40, segundo: 25)
    @hora3 = ServicioSanitario::Hora.new(hora: 14, minuto: 50, segundo: 15)
    @hora4 = @hora1
  end
  
  context "Inicialización y atributos" do
    it "Se espera poder crear una instancia de Hora" do
      # Comprobamos que la variable @hora no sea nil, lo que indica que se creó una instancia de la clase
      expect(@hora).not_to be_nil
      expect(@hora2).not_to be_nil
      expect(@hora3).not_to be_nil
    end

    # Prueba para verificar que los atributos hora, minuto y segundo se pueden acceder correctamente
    it "Se espera que se pueda acceder a la hora , minutos y segundos correctamente" do
      # Comprobamos que los atributos de la instancia de Hora son los valores esperados
      expect(@hora.hora).to eq(12)
      expect(@hora.minuto).to eq(30)
      expect(@hora.segundo).to eq(45)
      expect(@hora3.hora).to eq(14)
      expect(@hora2.minuto).to eq(40)
      expect(@hora3.segundo).to eq(15)
    end

    # Prueba para verificar que el formato de la hora es correcto
    it "Se espera que el formato de la hora sea correcto" do
      # Comprobamos que el método to_s devuelva el formato correcto
      expect(@hora.to_s).to eq("12:30:45")
      expect(@hora.to_s).to be_a(String)
      expect(@hora).not_to be_a(String)
    end
  end 

  context "Herencia" do
    it "Se espera que la instancia pertenezca a a la clase determinada" do
      # Comprobamos que el método to_s devuelva el formato correcto
      expect(@hora).to be_a(ServicioSanitario::Hora)
      expect(@hora1).to be_a(ServicioSanitario::Hora)
      expect(@hora.instance_of?(ServicioSanitario::Hora)).to be true
      expect(@nivel2.instance_of?(ServicioSanitario::Fecha)).to be false
      expect(ServicioSanitario::Hora.superclass).to eq(Object)
      expect(Object.superclass).to eq(BasicObject)
    end 
  end

  context "Métodos públicos de la clase Hora" do
    it "Se espera poder verificar los métodos públicos en Hora" do
      expect(@hora.public_methods).to include(:to_s)
      expect(@hora.public_methods).to include(:==)
      expect(@hora.public_methods).to include(:instance_of?)
      expect(@hora.public_methods).to include(:equal?)
    end
  end

  context "Igualdad de objetos" do
    it "Se espera que dos horas con la misma información no sean el mismo objeto usando equal?" do
        expect(@hora1).not_to equal(@hora3)
    end

    it "Se espera verificar la igualdad utilizando ==" do
        expect(@hora1).to eq(@hora4)
    end

    it "Se espera verificar la igualdad utilizando eql?" do
        expect(@hora1).to eql(@hora4)
    end

    it "Se espera verificar que los objetos con la misma referencia son iguales utilizando equal?" do
        expect(@hora1).to equal(@hora4)
    end

    it "Se espera verificar que dos objetos con atributos iguales pero diferente referencia no son iguales utilizando equal?" do
        expect(@hora1).not_to equal(@hora3)
    end

    it "Se espera verificar la igualad usando  === " do
        expect(@hora1 === @hora3).to be false
    end
  end

  context " Pruebas to_s" do
    it "Se espera que devuelva la hora en formato cadena " do
      expect(@hora.to_s).to eq("12:30:45")
      expect(@hora1.to_s).to eq("12:30:45")
      expect(@hora2.to_s).to eq("10:40:25")
    end

    it "Se espera que devuelva la misma cadena para dos instancias con los mismos valores" do
      expect(@hora.to_s).to eq(@hora1.to_s)
    end

    it "Se espera que devuelva una cadena diferente para instancias con valores diferentes" do
      expect(@hora.to_s).not_to eq(@hora2.to_s)
      expect(@hora.to_s).not_to eq(@hora3.to_s)
    end
  end

  context "Igualdad de objetos (COMPRABLE)" do
    it "Se espera que una fecha incluye el módulo Comparable" do 
      expect(ServicioSanitario::Hora.included_modules).to include(Comparable)
      expect(@hora.is_a?(Module)).to be(false)
      expect(@hora).to be_a(Comparable)
      expect(@hora).not_to be_a(Enumerable ) 
    end 
  end 

  
end
