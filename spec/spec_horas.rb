require 'spec_helper'
require 'ServicioSanitario/Horas'
require 'ServicioSanitario'


RSpec.describe ServicioSanitario::Hora do

  before(:each) do
    @hora = ServicioSanitario::Hora.new(hora: 12, minuto: 30, segundo: 45)
    @hora1 = ServicioSanitario::Hora.new(hora: 12, minuto: 30, segundo: 45)
    @hora2 = ServicioSanitario::Hora.new(hora: 10, minuto: 40, segundo: 25)
    @hora3 = ServicioSanitario::Hora.new(hora: 14, minuto: 50, segundo: 15)
    @hora4 = @hora1
  end
  
  context "Inicialización y atributos" do
    it "Se espera poder crear una instancia de Hora" do
      expect(@hora).not_to be_nil
      expect(@hora2).not_to be_nil
      expect(@hora3).not_to be_nil
    end

    it "Se espera que se pueda acceder a la hora , minutos y segundos correctamente" do
      expect(@hora.hora).to eq(12)
      expect(@hora.minuto).to eq(30)
      expect(@hora.segundo).to eq(45)
      expect(@hora3.hora).to eq(14)
      expect(@hora2.minuto).to eq(40)
      expect(@hora3.segundo).to eq(15)
    end

    it "Se espera que el formato de la hora sea correcto" do
      expect(@hora.to_s).to eq("12:30:45")
      expect(@hora.to_s).to be_a(String)
      expect(@hora).not_to be_a(String)
    end
  end 

  context "Herencia" do
    it "Se espera que la instancia pertenezca a a la clase determinada" do
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
    end 

    it "Se espera que la herencia sea correcta" do 
      expect(Comparable.class).to eq(Module)
      expect(Module.superclass).to eq(Object)
      expect(Object.superclass).to eq(BasicObject)
    end  

    it "Se espera que se verifique la igualdad (==)" do
      expect(@hora == @hora1).to be true
      expect(@hora == @hora2).to be false
    end

    it "Se espera que se verifique la igualdad menor que (<)" do
      expect(@hora2 < @hora).to be true
      expect(@hora < @hora3).to be true
      expect(@hora3 < @hora2).to be false
    end

    it "Se espera que se verifique la igualdad mayor que (>)" do
      expect(@hora3 > @hora).to be true
      expect(@hora > @hora2).to be true
      expect(@hora2 > @hora3).to be false
    end

    it "Se espera que se verifique la igualdad menor o igual que (<=)" do
      expect(@hora <= @hora1).to be true
      expect(@hora2 <= @hora).to be true
      expect(@hora3 <= @hora).to be false
    end

    it "Se espera que se verifique la igualdad  mayor o igual que (>=)" do
      expect(@hora >= @hora1).to be true
      expect(@hora >= @hora2).to be true
      expect(@hora2 >= @hora3).to be false
    end
  end 

  context "Igualdad de objetos (ENUMERABLE)" do
    it "Se espera que una fecha incluye el módulo Comparable" do 
      expect(ServicioSanitario::Hora.included_modules).to include(Enumerable)
      expect(@hora.is_a?(Module)).to be(false)
      expect(@hora).to be_a(Enumerable ) 
    end 

    it "Se espera que la herencia sea correcta" do 
      expect(Enumerable.class).to eq(Module)
      expect(Module.superclass).to eq(Object)
      expect(Object.superclass).to eq(BasicObject)
    end  
  end 
end
