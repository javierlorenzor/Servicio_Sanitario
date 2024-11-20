require 'spec_helper'
require 'ServicioSanitario/Persona'
require 'ServicioSanitario/Fecha'
require 'ServicioSanitario'
require 'date'

RSpec.describe ServicioSanitario::Persona do
  before(:each) do
    @fecha1 = ServicioSanitario::Fecha.new(dia: 19, mes: 7, anio: 2001)
    @fecha2 = ServicioSanitario::Fecha.new(dia: 23, mes: 9, anio: 2004)
    @fecha3 = ServicioSanitario::Fecha.new(dia: 15, mes: 11, anio: 2024)
    @persona1 = ServicioSanitario::Persona.new("12345", "Juan", "Pérez", "M", @fecha1)
    @persona2 = ServicioSanitario::Persona.new("67890", "Ana", "García", "F", @fecha2)
    @persona3 = ServicioSanitario::Persona.new("12345", "Juan", "Pérez", "M", @fecha1)
    @persona4 = @persona1
  end

  context "Inicialización y herencia " do
    it "Se espera que se pueda inicializar persona correctamente con valores válidos" do
      #expect(@persona1).not_to be_nil
      #expect(@fecha1).not_to be_nil
    end

    it "Se espera que la instancia pertenezca a la clase determinada" do
      expect(@persona1).to be_a(ServicioSanitario::Persona)
      expect(@persona2).to be_a(ServicioSanitario::Persona)
      expect(@persona1.instance_of?(ServicioSanitario::Persona)).to be true
    end
  end

  context "Acceso a atributos" do
    it "Se debe tener acceso de lectura a los atributos" do
      expect(@persona1.numero_identificacion).to eq("12345")
      expect(@persona2.numero_identificacion).to eq("67890")
      expect(@persona1.nombre_completo).to eq("Juan Pérez")
      expect(@persona2.nombre_completo).to eq("Ana García")
      expect(@persona1.sexo).to eq("M")
      expect(@persona2.sexo).to eq("F")
      expect(@persona1.obtener_fecha).to eq(@fecha1)
      expect(@persona2.obtener_fecha).to eq(@fecha2)
    end
  end

  context "Método to_s " do
     it "Se espera que se devuelva una cadena con la información completa de la persona" do
       expect(@persona1.to_s).to eq("Nombre: Juan Pérez, ID: 12345, Sexo: M, Fecha de nacimiento: 19/7/2001")
       expect(@persona2.to_s).to eq("Nombre: Ana García, ID: 67890, Sexo: F, Fecha de nacimiento: 23/9/2004")
    end
  end

   context "Contador de instancias" do
     it "Se espera que se incremente el contador cada vez que se crea una nueva instancia" do
       ServicioSanitario::Persona.class_variable_set(:@@instancia_contador, 0)
       expect(ServicioSanitario::Persona.contador_instancias).to eq(0)

       # Crea una nueva instancia y verifica el incremento
       persona1 = ServicioSanitario::Persona.new("54321", "Carlos", "López", "M", "12/11/2005")
       expect(ServicioSanitario::Persona.contador_instancias).to eq(1)

       # Crea otra instancia y verifica el incremento
       persona2 = ServicioSanitario::Persona.new("12345", "Ana", "Martínez", "F", "23/06/1998")
       expect(ServicioSanitario::Persona.contador_instancias).to eq(2)
     end

     it "Se espera que contador_instancias no sea accesible desde fuera de la clase" do
       # Intentamos acceder al método contador_instancias desde un objeto de la clase (que es una instancia)
       expect { @persona1.contador_instancias }.to raise_error(NoMethodError)
     end
   end

   context "Método edad " do
     it "Se espera poder calcular correctamente la edad de la persona" do
       expect(@persona1.edad(@fecha3)).to eq(23)
       expect(@persona2.edad(@fecha3)).to eq(20)
     end

     it "Se espera que edad al ser público pueda ser accesible desde fuera de la clase" do
       fecha_actual = ServicioSanitario::Fecha.new(dia: 15, mes: 11, anio: 2024)
       expect(@persona1.edad(fecha_actual)).to eq(23) 
     end
  end

  context "Igualdad de objetos" do
    it "Se espera verificar la igualdad utilizando ==" do
      expect(@persona1).to eq(@persona4) # Los atributos son iguales, por lo tanto deberían ser iguales
    end

    it "Se espera verificar la igualdad utilizando eql?" do
      expect(@persona1).to eql(@persona4) # Igualdad estricta, se espera que sean iguales
    end

    it "Se espera verificar que los objetos con la misma referencia son iguales utilizando equal?" do
      expect(@persona1).to equal(@persona4) # Mismo objeto en memoria, por lo que equal? debe devolver true
    end

    it "Se espera verificar que dos objetos con atributos iguales pero diferente referencia no son iguales utilizando equal?" do
      expect(@persona1).not_to equal(@persona3) # Aunque los atributos sean iguales, son objetos diferentes en memoria
    end

    it "Se espera verificar que === no se usa comúnmente para la comparación de objetos directos" do
      expect(@persona1 === @persona3).to be true  
    end
  end

  context "Métodos públicos de la clase Persona" do
    it "Se espera poder verificar los métodos públicos en Persona" do
      expect(@persona.public_methods).to include(:to_s)
      expect(@persona.public_methods).to include(:==)
      expect(@persona.public_methods).to include(:instance_of?)
      expect(@persona.public_methods).to include(:equal?)
    end
  end

  context "Visibilidad de las clases" do
    it "Se espera poder acceder a métodos públicos" do
      expect(@persona1.nombre_completo).to eq("Juan Pérez")
      expect(@persona1.to_s).to include("12345")
    end

    it "Se espera no poder acceder a métodos privados directamente" do
      expect { @persona1.set_nombre("Pedro") }.to raise_error(NoMethodError)
      expect { @persona1.set_apellido("Lopez") }.to raise_error(NoMethodError)
    end

    it "Se espera no poder acceder a métodos protegidos directamente" do
      expect { @persona1.fecha_nacimiento }.to raise_error(NoMethodError)
    end

    it "Se espera verificar que los métodos privados son utilizados internamente" do
      @persona1.set_nombre_completo("Carlos López")
      expect(@persona1.nombre_completo).to eq("Carlos López")
    end

    it "Se espera poder compartir la misma referencia de objeto" do
      expect(@persona4).to equal(@persona1) # misma referencia de objeto
    end

    it "Se espera poder comparar correctamente dos instancias con los mismos valores" do
      expect(@persona1).not_to equal(@persona3) # diferentes objetos
      expect(@persona1.nombre_completo).to eq(@persona3.nombre_completo)
    end

  end 

  context "Igualdad de objetos (COMPRABLE)" do
    it "Se espera que una fecha incluye el módulo Comparable" do 
      expect(ServicioSanitario::Persona.included_modules).to include(Comparable)
      expect(@persona1.is_a?(Module)).to be(false)
      expect(@persona1).to be_a(Comparable)
    end 

    it "Se espera que la herencia sea correcta" do 
      expect(Comparable.class).to eq(Module)
      expect(Module.superclass).to eq(Object)
      expect(Object.superclass).to eq(BasicObject)
    end  

    it "verifica igualdad (==)" do
      expect(@persona1 == @persona3).to be true
      expect(@persona1 == @persona2).to be false
    end

    it "verifica menor que (<)" do
      expect(@persona2 < @persona1).to be true # Ana es más joven que Juan
      expect(@persona1 < @persona2).to be false
    end

    it "verifica mayor que (>)" do
      expect(@persona1 > @persona2).to be true # Juan es mayor que Ana
      expect(@persona2 > @persona1).to be false
    end

    it "verifica menor o igual que (<=)" do
      expect(@persona2 <= @persona1).to be true
      expect(@persona1 <= @persona3).to be true
    end

    it "verifica mayor o igual que (>=)" do
      expect(@persona1 >= @persona2).to be true
      expect(@persona1 >= @persona3).to be true
    end

  end 

  context "Igualdad de objetos (ENUMERABLE)" do
    it "Se espera que una fecha incluye el módulo Enumerable" do 
      expect(ServicioSanitario::Persona.included_modules).to include(Enumerable)
      expect(@persona1.is_a?(Module)).to be(false)
      expect(@persona1).to be_a(Enumerable) 
    end 

    it "Se espera que la herencia sea correcta" do 
      expect(Enumerable.class).to eq(Module)
      expect(Module.superclass).to eq(Object)
      expect(Object.superclass).to eq(BasicObject)
    end  
  end 
 end
