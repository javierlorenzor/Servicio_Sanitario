require 'spec_helper'
require 'ServicioSanitario/Titular'
require 'ServicioSanitario/NivelSet'
require 'ServicioSanitario/Persona'
require 'ServicioSanitario/Paciente'
require 'ServicioSanitario/Titular'
require 'ServicioSanitario'

# Descripción de las pruebas para la clase ServicioSanitario::titular
RSpec.describe ServicioSanitario::Titular do
  before(:each) do
    # Creación de fechas
    @fecha1 = ServicioSanitario::Fecha.new(dia: 10, mes: 5, anio: 1980)
    @fecha2 = ServicioSanitario::Fecha.new(dia: 20, mes: 6, anio: 1990)
  
    # Creación de médicos y pacientes
    @titular1 = ServicioSanitario::Titular.new("12345", "Alba", "Pérez", "F", @fecha1, "Pediatría", 5)
    @titular2 = ServicioSanitario::Titular.new("56789", "Miguel", "Tadeo", "M", @fecha2, "Geriatría", 3)
    @titular3 = ServicioSanitario::Titular.new("12345", "Alba", "Pérez", "F", @fecha1, "Pediatría", 5)
    @titular4 = @titular1

  
    @paciente1 = ServicioSanitario::Paciente.new("54321", "Maria", "Gomez", "F", @fecha1, ServicioSanitario::AZUL)
    @paciente2 = ServicioSanitario::Paciente.new("67890", "Carlos", "Ruiz", "M", @fecha2, ServicioSanitario::AZUL)
    @paciente1 = ServicioSanitario::Paciente.new("54321", "Juan", "Marrero", "F", @fecha1, ServicioSanitario::AZUL)
    @paciente2 = ServicioSanitario::Paciente.new("67890", "Ana", "Dorta", "M", @fecha2, ServicioSanitario::AZUL)
  end

  context "Inicialización y clases" do

    it "Se espera que se pueda inicializar persona correctamente con valores válidos" do
      expect(@titular1).not_to be_nil
      expect(@titular2).not_to be_nil
    end

    it "Se espera que la instancia pertenezca a la clase determinada" do
      expect(@titular1).to be_a(ServicioSanitario::Titular)
      expect(@titular2).to be_a(ServicioSanitario::Titular)
      expect(@titular1.instance_of?(ServicioSanitario::Titular)).to be true
      expect(ServicioSanitario::Titular.superclass).to eq(ServicioSanitario::Medico)
      expect(ServicioSanitario::Medico.superclass).to eq(ServicioSanitario::Persona)
      expect(ServicioSanitario::Persona.superclass).to eq(Object)
      expect(Object.superclass).to eq(BasicObject)
    end

    it "Se espera que devuelva el valor esperado" do
      expect(@titular1.numero_identificacion).to eq("12345")
      expect(@titular1.nombre_completo).to eq("Alba Pérez")
      expect(@titular1.sexo).to eq("F")
      expect(@titular1.obtener_fecha).to eq(@fecha1)
      expect(@titular1.especialidad).to eq("Pediatría")
      expect(@titular1.maximo_pacientes).to eq(5)
    end

  end


  context "Comprobaciones metodo maximo" do

    it 'Se espera retornar false cuando el número de pacientes es menor que el máximo' do
      @titular1.pacientes << @paciente1
      @titular1.pacientes << @paciente2
      expect(@titular1.carga_max?).to be false 
    end

    it 'Se espera retornar true cuando el número de pacientes es igual o mayor que el máximo' do
      @titular2.pacientes << @paciente1
      @titular2.pacientes << @paciente2
      @titular2.pacientes << @paciente3
      @titular2.pacientes << @paciente4
      expect(@titular2.carga_max?).to be true 
    end

    it 'Se espera que se muestre correctamente la información del titular sin carga máxima alcanzada' do
      # Añadimos algunos pacientes al titular1, pero sin alcanzar el máximo
      @titular1.pacientes << @paciente1
      @titular1.pacientes << @paciente2
      expected_output = "Alba Pérez, ID: 12345, Sexo: F, Fecha de Nacimiento: #{@fecha1}, Especialidad: Pediatría, Número de Pacientes: 2, Máximo de Pacientes: 5, Carga Máxima Alcanzada: false"
      expect(@titular1.to_s).to eq(expected_output)
    end

    it 'Se espera que se muestre correctamente la información del titular con carga máxima alcanzada' do
      # Añadimos pacientes al titular2 para alcanzar la carga máxima
      @titular2.pacientes << @paciente1
      @titular2.pacientes << @paciente2
      @titular2.pacientes << @paciente3
      expected_output = "Miguel Tadeo, ID: 56789, Sexo: M, Fecha de Nacimiento: #{@fecha2}, Especialidad: Geriatría, Número de Pacientes: 3, Máximo de Pacientes: 3, Carga Máxima Alcanzada: true"
      expect(@titular2.to_s).to eq(expected_output)
    end

  end 

  context "Métodos públicos de la clase Titular" do

    it "Se espera poder verificar los métodos públicos en Titular" do
      expect(@titular.public_methods).to include(:to_s)
      expect(@titular.public_methods).to include(:==)
      expect(@titular.public_methods).to include(:instance_of?)
      expect(@titular.public_methods).to include(:equal?)
      expect(ServicioSanitario::Titular.public_instance_methods).to include(:carga_max?)
    end

  end

  context "Igualdad de objetos" do
    it "Se espera verificar la igualdad utilizando ==" do
      expect(@titular1).to eq(@titular4) # Los atributos son iguales, por lo tanto deberían ser iguales
    end

    it "Se espera verificar la igualdad utilizando eql?" do
      expect(@titular1).to eql(@titular4) # Igualdad estricta, se espera que sean iguales
    end

    it "Se espera verificar que los objetos con la misma referencia son iguales utilizando equal?" do
      expect(@titular1).to equal(@titular4) # Mismo objeto en memoria, por lo que equal? debe devolver true
    end

    it "Se espera verificar que dos objetos con atributos iguales pero diferente referencia no son iguales utilizando equal?" do
      expect(@titular1).not_to equal(@titular3) # Aunque los atributos sean iguales, son objetos diferentes en memoria
    end

    it "Se espera verificar la igualdad con  === " do
      expect(@titular1 === @titular3).to be true 
    end
  end

  context "Igualdad de objetos (COMPRABLE)" do
    it "Se espera que una fecha incluye el módulo Comparable" do 
      expect(ServicioSanitario::Titular.included_modules).to include(Comparable)
      expect(@titular1.is_a?(Module)).to be(false)
      expect(@titular1).to be_a(Comparable)
    end 

    it "Se espera que la herencia sea correcta" do 
      expect(Comparable.class).to eq(Module)
      expect(Module.superclass).to eq(Object)
      expect(Object.superclass).to eq(BasicObject)
    end  
    it "Se espera que un titular con menos pacientes sea menor que otro con más pacientes" do
      # Agregar pacientes
      @titular1.pacientes << @paciente1
      @titular2.pacientes << @paciente3 << @paciente4
  
      expect(@titular1 < @titular2).to be true
    end
  
    it "Se espera que un titular con el mismo número de pacientes sea igual a otro con el mismo número de pacientes" do
      # Agregar pacientes
      @titular1.pacientes << @paciente1
      @titular2.pacientes << @paciente3
  
      expect(@titular1 == @titular2).to be true
    end
  
    it "Se espera que un titular con más pacientes sea mayor o igual que otro con menos pacientes" do
      # Agregar pacientes
      @titular1.pacientes << @paciente1 << @paciente2
      @titular2.pacientes << @paciente3
  
      expect(@titular1 >= @titular2).to be true
    end
  
    it "Se espera que un titular con menos pacientes sea menor o igual que otro con más pacientes" do
      # Agregar pacientes
      @titular1.pacientes << @paciente1
      @titular2.pacientes << @paciente3 << @paciente4
  
      expect(@titular1 <= @titular2).to be true
    end
  
    it "Se espera que el mismo titular comparado consigo mismo sea igual" do
      expect(@titular1 == @titular1).to be true
    end
  
    it "Se espera que un titular con el mismo número de pacientes sea igual a otro mismo titular" do
      expect(@titular1 == @titular3).to be true
    end
  
    it "Se espera que el titular con más pacientes sea mayor que el titular con menos pacientes" do
      @titular1.pacientes << @paciente1 << @paciente2
      @titular2.pacientes << @paciente3
      expect(@titular1 > @titular2).to be true
    end
  
    it "Se espera que el titular con menos pacientes sea menor que el titular con más pacientes" do
      @titular1.pacientes << @paciente1
      @titular2.pacientes << @paciente3 << @paciente4
      expect(@titular1 < @titular2).to be true
    end
    
  end

  context "Recorrer objetos (ENUMERABLE)" do
    it "Se espera que una fecha incluye el módulo Enumerable" do 
      expect(ServicioSanitario::Titular.included_modules).to include(Enumerable)
      expect(@titular1.is_a?(Module)).to be(false)
      expect(@titular1).to be_a(Enumerable) 
    end 

    it "Se espera que la herencia sea correcta" do 
      expect(Enumerable.class).to eq(Module)
      expect(Module.superclass).to eq(Object)
      expect(Object.superclass).to eq(BasicObject)
    end  
  end 
end 
