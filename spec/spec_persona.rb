require 'spec_helper'
require 'ServicioSanitario/Persona'
require 'ServicioSanitario/Fecha'
require 'ServicioSanitario'

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
      expect(@persona1).not_to be_nil
      expect(@persona2).not_to be_nil
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
      expect(@persona1.nombre).to eq("Juan")
      expect(@persona2.nombre).to eq("Ana")
      expect(@persona1.apellido).to eq("Pérez")
      expect(@persona2.apellido).to eq("García")
      expect(@persona1.sexo).to eq("M")
      expect(@persona2.sexo).to eq("F")
      expect(@persona1.fecha_nacimiento).to eq(@fecha1)
      expect(@persona2.fecha_nacimiento).to eq(@fecha2)
    end
  end

  context "Método to_s " do
    it "Se espera que se devuelva una cadena con la información completa de la persona" do
      expect(@persona1.to_s).to eq("Juan Pérez, ID: 12345, Sexo: M, Fecha de Nacimiento: 19/7/2001")
      expect(@persona2.to_s).to eq("Ana García, ID: 67890, Sexo: F, Fecha de Nacimiento: 23/9/2004")
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
      expect(@persona1.edad(fecha_actual)).to eq(23) # Suponiendo que la lógica calcule la edad correctamente
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
      expect(@persona1 === @persona3).to be false  # `===` se usa más comúnmente para casos como la comparación de clases, no tanto de igualdad de objetos
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
end
