require 'spec_helper'
require 'ServicioSanitario/Persona'
require 'ServicioSanitario/NivelSet'
require 'ServicioSanitario/Paciente'
require 'ServicioSanitario'

# Descripción de las pruebas para la clase ServicioSanitario::Paciente
RSpec.describe ServicioSanitario::Paciente do
  before(:each) do
    @fecha1 = ServicioSanitario::Fecha.new(dia: 19, mes: 7, anio: 2001)
    @fecha2 = ServicioSanitario::Fecha.new(dia: 23, mes: 9, anio: 2004)
    @paciente1 = ServicioSanitario::Paciente.new("12345", "Juan", "Pérez", "M", @fecha1, ServicioSanitario::AZUL)
    @paciente2 = ServicioSanitario::Paciente.new("67890", "Ana", "García", "F", @fecha2, ServicioSanitario::NEGRO)
    @paciente3 = ServicioSanitario::Paciente.new("12345", "Juan", "Pérez", "M", @fecha1, ServicioSanitario::AZUL)
    @paciente5 = ServicioSanitario::Paciente.new("12345", "Juan", "Pérez", "M", @fecha1, ServicioSanitario::VERDE)
    @paciente4 = @paciente1
    
    @pacientes = [@paciente1, @paciente2, @paciente3, @paciente5]
  end

  context "Inicialización y atributos" do
    it "Se espera que se pueda inicializar persona correctamente con valores válidos" do
      expect(@paciente1).not_to be_nil
      expect(@paciente2).not_to be_nil
    end

    it "Se espera que la instancia pertenezca a la clase determinada" do
      expect(@paciente1).to be_a(ServicioSanitario::Paciente)
      expect(@paciente2).to be_a(ServicioSanitario::Paciente)
      expect(@paciente1.instance_of?(ServicioSanitario::Paciente)).to be true
      expect(ServicioSanitario::Paciente.superclass).to eq(ServicioSanitario::Persona)
      expect(ServicioSanitario::Persona.superclass).to eq(Object)
      expect(Object.superclass).to eq(BasicObject)
    end

    it "Se espera que se devuelva el valor esperado " do
      expect(@paciente1.numero_identificacion).to eq("12345")
      expect(@paciente2.numero_identificacion).to eq("67890")
      #expect(@paciente1.nombre_completo).to eq("Juan Pérez")
      expect(@paciente1.sexo).to eq("M")
      expect(@paciente1.obtener_fecha).to eq(@fecha1)
      expect(@paciente1.prioridad).to eq(ServicioSanitario::AZUL)
      expect(@paciente1.diagnosticos).to eq([])
    end
  end

  context "Igualdad de objetos" do
    it "Se espera que dos pacientes con la misma información no sean el mismo objeto usando equal?" do
      expect(@paciente1).not_to equal(@paciente3)
    end

    it "Se espera verificar la igualdad utilizando ==" do
      expect(@paciente1).to eq(@paciente4)
    end

    it "Se espera verificar la igualdad utilizando eql?" do
      expect(@paciente1).to eql(@paciente4)
    end

    it "Se espera verificar que los objetos con la misma referencia son iguales utilizando equal?" do
      expect(@paciente1).to equal(@paciente4)
    end

    it "Se espera verificar que dos objetos con atributos iguales pero diferente referencia no son iguales utilizando equal?" do
      expect(@paciente1).not_to equal(@paciente3)
    end

    it "Se espera verificar la igualad usando  === " do
      expect(@paciente1 === @paciente3).to be true 
    end
  end

  context "Atributos y diagnóstico" do
    it "Se debe devolver nil si no hay diagnósticos" do
      expect(@paciente1.diagnosticos).to be_empty
      expect(@paciente2.diagnosticos).to be_empty
    end

    it "Se debe permitir agregar un diagnóstico a la variable diagnosticos" do
      @paciente1.diagnosticos << "Diagnóstico inicial"
      expect(@paciente1.diagnosticos).to include("Diagnóstico inicial")
    end
    
    it "Se debe tener la variable diagnosticos no vacía después de añadir un diagnóstico" do
      @paciente1.diagnosticos << "Diagnóstico inicial"
      expect(@paciente1.diagnosticos).not_to be_empty
    end

    it "Se debe devolver nil cuando no hay diagnósticos en el método ultimo_diagnostico" do
      expect(@paciente1.ultimo_diagnostico).to be_nil
      expect(@paciente2.ultimo_diagnostico).to be_nil
    end

    it "Se debe devolver el último diagnóstico cuando hay uno o más diagnósticos" do
      @paciente1.diagnosticos << "Diagnóstico 1"
      expect(@paciente1.ultimo_diagnostico).to eq("Diagnóstico 1")

      @paciente1.diagnosticos << "Diagnóstico 2"
      expect(@paciente1.ultimo_diagnostico).to eq("Diagnóstico 2")

      @paciente2.diagnosticos << "Diagnóstico 1"
      @paciente2.diagnosticos << "Diagnóstico 2"
      @paciente2.diagnosticos << "Diagnóstico 3"
      
      expect(@paciente2.ultimo_diagnostico).to eq("Diagnóstico 3")
    end
  end

  context "Métodos públicos de la clase Paciente" do
    it "Se espera poder verificar los métodos públicos en Paciente" do
      expect(@paciente1.public_methods).to include(:to_s)
      expect(@paciente1.public_methods).to include(:==)
      expect(@paciente1.public_methods).to include(:instance_of?)
      expect(@paciente1.public_methods).to include(:equal?)
      expect(ServicioSanitario::Paciente.public_instance_methods).to include(:ultimo_diagnostico)
    end
  end

  context "Método to_s" do
    it "Se debe devolver una cadena con la información completa de la persona con diagnósticos vacíos" do
      expect(@paciente1.to_s).to eq("Juan Pérez, ID: 12345, Sexo: M, Fecha de Nacimiento: #{@fecha1}, Prioridad: #{ServicioSanitario::AZUL}, Diagnósticos: ")
      expect(@paciente2.to_s).to eq("Ana García, ID: 67890, Sexo: F, Fecha de Nacimiento: #{@fecha2}, Prioridad: #{ServicioSanitario::NEGRO}, Diagnósticos: ")
    end

    it "Se debe incluir los diagnósticos en el método to_s si se agregan" do
      @paciente1.diagnosticos << "Diagnóstico 1"
      @paciente1.diagnosticos << "Diagnóstico 2"
      expect(@paciente1.to_s).to eq("Juan Pérez, ID: 12345, Sexo: M, Fecha de Nacimiento: #{@fecha1}, Prioridad: #{ServicioSanitario::AZUL}, Diagnósticos: Diagnóstico 1, Diagnóstico 2")
    end
  end

  context "Igualdad de objetos (COMPRABLE)" do
    it "Se espera que una fecha incluye el módulo Comparable" do 
      expect(ServicioSanitario::Paciente.included_modules).to include(Comparable)
      expect(@paciente1.is_a?(Module)).to be(false)
      expect(@paciente1).to be_a(Comparable)
    end 

    it "Se espera que la herencia sea correcta" do 
      expect(Comparable.class).to eq(Module)
      expect(Module.superclass).to eq(Object)
      expect(Object.superclass).to eq(BasicObject)
    end  

    it "Se espera poder comparar correctamente pacientes con la misma prioridad" do
      expect(@paciente1 <=> @paciente3).to eq(0)
    end
  
    it "Se espera poder comparar pacientes con diferente prioridad" do
      expect(@paciente5 < @paciente2).to be true
    end
  
    it "Se espera poder ser mayor si la prioridad del paciente actual es mayor que la del otro" do
      expect(@paciente2 > @paciente5).to be true 
    end
  
    it "Se espera poder ser menor si la prioridad del paciente actual es menor que la del otro" do
      expect(@paciente2 < @paciente1).to be false
    end

    it "Se espera poder comparar correctamente pacientes con la misma prioridad y atributos idénticos" do
      expect(@paciente1 == @paciente3).to be true
    end

    it "Se espera poder comparar pacientes con atributos diferentes" do
      expect(@paciente1 == @paciente2).to be false
    end

    it "Se espera poder comprobar between?" do
      expect(@paciente5.between?(@paciente1, @paciente2)).to be true 
      expect(@paciente2.between?(@paciente1, @paciente5)).to be false
    end
  end 

  context "Recorrer objetos (ENUMERABLE)" do
    it "Se espera que una fecha incluye el módulo Enumerable" do 
      expect(ServicioSanitario::Paciente.included_modules).to include(Enumerable)
      expect(@paciente1.is_a?(Module)).to be(false)
      expect(@paciente1).to be_a(Enumerable) 
    end 

    it "Se espera que la herencia sea correcta" do 
      expect(Enumerable.class).to eq(Module)
      expect(Module.superclass).to eq(Object)
      expect(Object.superclass).to eq(BasicObject)
    end  

    it "utiliza select para filtrar pacientes con prioridad AZUL" do
      resultado = @pacientes.select { |p| p.prioridad == ServicioSanitario::AZUL }
      expect(resultado).to eq([@paciente1, @paciente3])
    end
  
    it "utiliza map para obtener nombres completos" do
      nombres = @pacientes.map(&:nombre_completo)
      expect(nombres).to include("Juan Pérez", "Ana García")
    end
  
    it "utiliza any? para verificar si hay pacientes con diagnósticos" do
      @paciente1.diagnosticos << "Gripe"
      tiene_diagnosticos = @pacientes.any? { |p| !p.diagnosticos.empty? }
      expect(tiene_diagnosticos).to be(true)
    end
  
    it "utiliza each para iterar sobre pacientes y obtener los identificadores" do
      ids = []
      @pacientes.each { |p| ids << p.numero_identificacion }
      expect(ids).to match_array(["12345", "67890", "12345", "12345"])
    end
  
    it "utiliza find para encontrar un paciente con prioridad NEGRO" do
      paciente_negro = @pacientes.find { |p| p.prioridad == ServicioSanitario::NEGRO }
      expect(paciente_negro).to eq(@paciente2)
    end
  
    it "utiliza reject para excluir pacientes sin diagnósticos" do
      @paciente1.diagnosticos << "Gripe"
      @paciente5.diagnosticos << "Tos"
      con_diagnosticos = @pacientes.reject { |p| p.diagnosticos.empty? }
      expect(con_diagnosticos).to eq([@paciente1, @paciente5])
    end
  end 
end 

       