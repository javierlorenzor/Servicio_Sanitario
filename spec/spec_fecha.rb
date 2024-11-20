require 'spec_helper'
require 'ServicioSanitario/Fecha'
require 'ServicioSanitario'

# Descripción de las pruebas para la clase ServicioSanitario::Fecha
RSpec.describe ServicioSanitario::Fecha do
  # Se ejecuta antes de cada prueba para crear instancias de Fecha
  before(:each) do
    @fecha = ServicioSanitario::Fecha.new(dia: 15, mes: 11, anio: 2024)
    @fecha1 = ServicioSanitario::Fecha.new(dia: 15, mes: 11, anio: 2024)
    @fecha2 = ServicioSanitario::Fecha.new(dia: 19, mes: 7, anio: 2001)
    @fecha3 = ServicioSanitario::Fecha.new(dia: 23, mes: 9, anio: 2001)
    @fecha4 = ServicioSanitario::Fecha.new(dia: 8, mes: 11, anio: 2024)
    @fecha5 = @fecha
  end

  context "Inicialización y herencia " do
    # Verifica que se puede crear una instancia de la clase Fecha
    it "Se espera poder crear una instancia de Fecha" do
      expect(@fecha).not_to be_nil
      expect(@fecha1).not_to be_nil
      expect(@fecha2).not_to be_nil
    end

    it "Se espera que la instancia pertenezca a a la clase determinada" do
      # Comprobamos que el método to_s devuelva el formato correcto
      expect(@fecha).to be_a(ServicioSanitario::Fecha)
      expect(@fecha).to be_a(ServicioSanitario::Fecha)
      expect(@fecha.instance_of?(ServicioSanitario::Fecha)).to be true
      expect(ServicioSanitario::Fecha.superclass).to eq(Object)
      expect(Object.superclass).to eq(BasicObject)
    end

    it "Se espera poder acceder a los atributos de la fecha (getters)" do
      expect(@fecha.dia).to eq(15)
      expect(@fecha.mes).to eq(11)
      expect(@fecha.anio).to eq(2024)
      expect(@fecha2.dia).to eq(19)
      expect(@fecha2.mes).to eq(07)
      expect(@fecha2.anio).to eq(2001)
    end

  end 

  context "Metodos" do
    # Verifica que la fecha se pueda representar correctamente como una cadena
    it "Se espera poder representar la fecha como cadena de manera correcta" do
      expect(@fecha.to_s).to eq("15/11/2024")
      expect(@fecha.to_s).to be_a(String)
      expect(@fecha2.to_s).to eq("19/7/2001")
      expect(@fecha2).not_to be_a(String)
    end
  end 

  context "Métodos públicos de la clase Fecha" do

    it "Se espera poder verificar los métodos públicos en Fecha" do
      expect(@titular.public_methods).to include(:to_s)
      expect(@titular.public_methods).to include(:==)
      expect(@titular.public_methods).to include(:instance_of?)
      expect(@titular.public_methods).to include(:equal?)
    end

  end

  context "Igualdad de objetos" do
    it "Se espera verificar la igualdad utilizando ==" do
      expect(@fecha).to eq(@fecha5) # Los atributos son iguales, por lo tanto deberían ser iguales
    end

    it "Se espera verificar la igualdad utilizando eql?" do
      expect(@fecha).to eql(@fecha5) # Igualdad estricta, se espera que sean iguales
    end

    it "Se espera verificar que los objetos con la misma referencia son iguales utilizando equal?" do
      expect(@fecha).to equal(@fecha5) # Mismo objeto en memoria, por lo que equal? debe devolver true
    end

    it "Se espera verificar que dos objetos con atributos iguales pero diferente referencia no son iguales utilizando equal?" do
      expect(@fecha).not_to equal(@fecha1) # Aunque los atributos sean iguales, son objetos diferentes en memoria
    end

    it "Se espera verificar la igualdad usando === " do
      expect(@fecha === @fecha1).to be true   
    end
  end

  context "Igualdad de objetos (COMPARABLE)" do
    it "Se espera que una fecha incluye el módulo Comparable" do 
      expect(ServicioSanitario::Fecha.included_modules).to include(Comparable)
      expect(@fecha.is_a?(Module)).to be(false)
      expect(@fecha).to be_a(Comparable)
    end 

    it "se espera que la herencia sea correcta" do 
      expect(@fecha).to be_a(Comparable)
      expect(Comparable.class).to eq(Module)
      expect(Module.superclass).to eq(Object)
      expect(Object.superclass).to eq(BasicObject)
    end  

    it "Se espera que se cumplan las restricciones de herencia" do 
      expect(ServicioSanitario::Fecha.class).to eq(Class)
      expect(Class.superclass).to eq(Module)
    end 

    it "Se espera poder verificar la  igualdad (==)" do
      expect(@fecha == @fecha1).to be true
      expect(@fecha == @fecha2).to be false
    end

    it "Se espera poder verificar menor que (<)" do
      expect(@fecha2 < @fecha3).to be true
      expect(@fecha3 < @fecha4).to be true
      expect(@fecha < @fecha4).to be false
    end

    it "Se espera poder verificar mayor que (>)" do
      expect(@fecha > @fecha3).to be true
      expect(@fecha4 > @fecha2).to be true
      expect(@fecha2 > @fecha).to be false
    end

    it "Se espera poder verificar menor o igual que (<=)" do
      expect(@fecha <= @fecha1).to be true
      expect(@fecha2 <= @fecha3).to be true
      expect(@fecha3 <= @fecha2).to be false
    end

    it "Se espera poder verificar mayor o igual que (>=)" do
      expect(@fecha >= @fecha1).to be true
      expect(@fecha >= @fecha3).to be true
      expect(@fecha3 >= @fecha).to be false
    end

  end 

  context "Igualdad de objetos (ENUMERABLE)" do
    it "Se espera que una fecha incluye el módulo Enumerable" do 
      expect(ServicioSanitario::Fecha.included_modules).to include(Enumerable)
      expect(@fecha1.is_a?(Module)).to be(false)
      expect(@fecha1).to be_a(Enumerable ) 
    end 

    it "Se espera que la herencia sea correcta" do 
      expect(Enumerable.class).to eq(Module)
      expect(Module.superclass).to eq(Object)
      expect(Object.superclass).to eq(BasicObject)
    end  

    it "Se espera poder iterar sobre cada elemento con each" do
      result = []
      @fecha.each { |element| result << element }
      expect(result).to eq([15, 11, 2024])  # Día, mes y año
    end

    it "Se espera poder mapear los elementos usando map" do
      result = [@fecha, @fecha1, @fecha2].map { |fecha| fecha.dia }  # Extraemos el día
      expect(result).to eq([15, 15, 19])  # Los días de cada instancia
    end

    it "Se espera poder seleccionar fechas específicas usando select" do
      result = [@fecha, @fecha1, @fecha2, @fecha3].select { |fecha| fecha.anio == 2001 }
      expect(result).to eq([@fecha2, @fecha3])  # Seleccionamos las fechas de 2024
    end

    it "Se espera poder rechazar fechas específicas usando reject" do
      result = [@fecha, @fecha1, @fecha2, @fecha3].reject { |fecha| fecha.mes == 11 }
      expect(result).to eq([@fecha2, @fecha3])  # Rechazamos las fechas de noviembre
    end

    it "Se espera poder encontrar una fecha usando find" do
      result = [@fecha, @fecha1, @fecha2, @fecha3].find { |fecha| fecha.dia == 19 }
      expect(result).to eq(@fecha2)  # Debería encontrar la fecha con el día 8
    end

    it "Se espera poder devolver true si existe alguna fecha con cierto atributo usando any?" do
      result = [@fecha, @fecha1, @fecha2, @fecha3].any? { |fecha| fecha.anio == 2001 }
      expect(result).to be true  # Existen fechas con el año 2001
    end

    it "dSe espera poder  devolver false si no existe alguna fecha con cierto atributo usando any?" do
      result = [@fecha, @fecha1, @fecha2, @fecha3].any? { |fecha| fecha.dia == 31 }
      expect(result).to be false  # No existe ninguna fecha con el día 31
    end

  end 
end
