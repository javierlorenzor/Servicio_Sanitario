require 'spec_helper'
require 'ServicioSanitario/NivelSet'
require 'ServicioSanitario'

# Descripción de las pruebas para la clase ServicioSanitario::NivelSet
RSpec.describe ServicioSanitario::NivelSet do
  # Se ejecuta antes de cada prueba para crear una instancia de NivelSet
  before(:each) do
    # Crear la instancia de NivelSet con nivel, categoría y tiempo de atención
    @nivel1 = ServicioSanitario::NivelSet.new(:I, 'Reanimacion', 'Inmediato')
    @nivel2 = ServicioSanitario::NivelSet.new(:II, 'Emergencia', '7 min')
    @nivel3 = ServicioSanitario::NivelSet.new(:III, 'Urgente', '30 min')
    @nivel4 = ServicioSanitario::NivelSet.new(:IV, 'Menos Urgente', '45 min')
    @nivel5 = ServicioSanitario::NivelSet.new(:V, 'No Urgente', '60 min')
    @nivel = ServicioSanitario::NivelSet.new(:I, 'Reanimacion', 'Inmediato')
    @nivel6 = @nivel1
  end

  context "Inicialización y atributos" do
    it "Se espera poder crear una instancia de NivelSet" do
      expect(@nivel1).not_to be_nil
      expect(@nivel2).not_to be_nil
      expect(@nivel3).not_to be_nil
      expect(@nivel4).not_to be_nil
      expect(@nivel5).not_to be_nil
    end 

    it "Se espera que se pueda obtener el valor correcto de nivel" do
      @nivel1 = ServicioSanitario::NivelSet.new(:I, 'Reanimacion', 'Inmediato')
      expect(@nivel1.nivel).to eq(:I)
      expect(@nivel1.categoria).to eq('Reanimacion')
      expect(@nivel1.tiempo_atencion).to eq('Inmediato')
      expect(@nivel2.nivel).to eq(:II)
      expect(@nivel2.categoria).to eq('Emergencia')
      expect(@nivel2.tiempo_atencion).to eq('7 min')
      expect(@nivel5.nivel).to eq(:V)
      expect(@nivel5.categoria).to eq('No Urgente')
      expect(@nivel5.tiempo_atencion).to eq('60 min')
    end
  end 
  
  context "Pruebas de herencia" do 
    it "Se espera que la instancia pertenezca a a la clase determinada" do
      expect(@nivel1).to be_a(ServicioSanitario::NivelSet)
      expect(@nivel4).to be_a(ServicioSanitario::NivelSet)
      expect(@nivel2.instance_of?(ServicioSanitario::NivelSet)).to be true
      expect(@nivel2.instance_of?(ServicioSanitario::Fecha)).to be false
      expect(ServicioSanitario::NivelSet.superclass).to eq(Object)
      expect(Object.superclass).to eq(BasicObject)
    end 
  end

  context "Pruebas de to_s" do
    it "Se espera poder devolver la representación en cadena de manera correcta" do
      expect(@nivel1.to_s).to eq("Nivel: I, Categoría: Reanimacion, Tiempo de atención: Inmediato")
      expect(@nivel4.to_s).to be_a(String)
      expect(@nivel3.to_s).to eq("Nivel: III, Categoría: Urgente, Tiempo de atención: 30 min")
      expect(@nivel5).not_to be_a(String)
    end
  end

  context "Métodos públicos de la clase nivel" do
    it "Se espera poder verificar los métodos públicos en nivel" do
      expect(@nivel.public_methods).to include(:to_s)
      expect(@nivel.public_methods).to include(:==)
      expect(@nivel.public_methods).to include(:instance_of?)
      expect(@nivel.public_methods).to include(:equal?)
    end
  end

  context "Igualdad de objetos" do
    it "Se espera que dos nivels con la misma información no sean el mismo objeto usando equal?" do
      expect(@nivel1).not_to equal(@nivel)
    end

    it "Se espera verificar la igualdad utilizando ==" do
      expect(@nivel1).to eq(@nivel6)
    end

    it "Se espera verificar la igualdad utilizando eql?" do
      expect(@nivel1).to eql(@nivel6)
    end

    it "Se espera verificar que los objetos con la misma referencia son iguales utilizando equal?" do
      expect(@nivel1).to equal(@nivel6)
    end

    it "Se espera verificar que dos objetos con atributos iguales pero diferente referencia no son iguales utilizando equal?" do
      expect(@nivel1).not_to equal(@nivel)
    end

    it "Se espera verificar la igualad usando  === " do
      expect(@nivel1 === @nivel).to be false
    end
  end

  context "Igualdad de objetos (COMPRABLE)" do
    it "Se espera que una fecha incluye el módulo Comparable" do 
      expect(ServicioSanitario::Hora.included_modules).to include(Comparable)
      expect(@nivel.is_a?(Module)).to be(false)
      expect(@nivel).to be_a(Comparable)
      expect(@nivel).not_to be_a(Enumerable ) 
    end

    it "Se espera que la herencia sea correcta" do 
      expect(Comparable.class).to eq(Module)
      expect(Module.superclass).to eq(Object)
      expect(Object.superclass).to eq(BasicObject)
    end  

    it "Se espera verificar la igualdad (==)" do
      expect(@nivel1 == @nivel).to be true
      expect(@nivel1 == @nivel2).to be false
    end

    it "Se espera verificar la igualdadmenor que (<)" do
      expect(@nivel1 < @nivel2).to be true
      expect(@nivel2 < @nivel3).to be true
      expect(@nivel3 < @nivel4).to be true
      expect(@nivel4 < @nivel5).to be true
      expect(@nivel5 < @nivel1).to be false
    end

    it "Se espera verificar la igualdad mayor que (>)" do
      expect(@nivel5 > @nivel4).to be true
      expect(@nivel4 > @nivel3).to be true
      expect(@nivel3 > @nivel2).to be true
      expect(@nivel2 > @nivel1).to be true
      expect(@nivel1 > @nivel5).to be false
    end

    it "Se espera verificar la igualdad menor o igual que (<=)" do
      expect(@nivel1 <= @nivel).to be true
      expect(@nivel1 <= @nivel2).to be true
      expect(@nivel2 <= @nivel3).to be true
      expect(@nivel3 <= @nivel4).to be true
      expect(@nivel4 <= @nivel5).to be true
    end

    it "Se espera verificar la igualdad mayor o igual que (>=)" do
      expect(@nivel5 >= @nivel4).to be true
      expect(@nivel4 >= @nivel3).to be true
      expect(@nivel3 >= @nivel2).to be true
      expect(@nivel2 >= @nivel1).to be true
      expect(@nivel1 >= @nivel).to be true
    end
  end 
end
