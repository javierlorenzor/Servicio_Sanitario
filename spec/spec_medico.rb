require 'spec_helper'
require 'ServicioSanitario/Medico'
require 'ServicioSanitario/NivelSet'
require 'ServicioSanitario/Persona'
require 'ServicioSanitario/Paciente'
require 'ServicioSanitario'

# Descripción de las pruebas para la clase ServicioSanitario::Medico
RSpec.describe ServicioSanitario::Medico do

    before(:each) do
        @fecha1 = ServicioSanitario::Fecha.new(dia: 10, mes: 5, anio: 1980)
        @fecha2 = ServicioSanitario::Fecha.new(dia: 10, mes: 5, anio: 1980)

        @medico1 = ServicioSanitario::Medico.new("12345", "Alba", "Perez", "F", @fecha1, "Pediatría")
        @medico2 = ServicioSanitario::Medico.new("56789", "Miguel", "Tadeo", "M", @fecha2, "Pediatría")
        @medico3 = ServicioSanitario::Medico.new("12345", "Alba", "Perez", "F", @fecha1, "Pediatría")
        @medico4 = @medico1

        @paciente1 = ServicioSanitario::Paciente.new("54321", "Maria", "Gomez", "F", @fecha1, ServicioSanitario::ROJO)
        @paciente2 = ServicioSanitario::Paciente.new("67890", "Carlos", "Ruiz", "M", @fecha2, ServicioSanitario::AZUL)

    end

    context "Inicialización y atributos" do

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
            expect(ServicioSanitario::Persona.superclass).to eq(Object)
            expect(Object.superclass).to eq(BasicObject)
        end
        it "Se debe inicializar con los atributos correctos" do
            expect(@medico2.numero_identificacion).to eq("56789")
            expect(@medico2.nombre_completo).to eq("Miguel Tadeo")
            expect(@medico2.sexo).to eq("M")
            expect(@medico2.especialidad).to eq("Pediatría")
            expect(@medico2.pacientes).to be_empty
        end
    end 

    context "Manipular hash pacientes " do 

        it "Se debe permitir agregar pacientes al array de pacientes" do
            @medico1.pacientes << @paciente1
            expect(@medico1.pacientes).to include(@paciente1)
        end
    
        it "Se debe tener pacientes en el array después de agregar un paciente" do
            @medico2.pacientes << @paciente1
            expect(@medico2.pacientes).not_to be_empty
        end
    
        it "Se debe de tener un array vacío antes de agregar pacientes" do
            expect(@medico1.pacientes).to be_empty
        end
    
        it "Se debe poder eliminar un paciente del array" do
            @medico1.pacientes << @paciente1
            @medico1.pacientes.delete(@paciente1)
            expect(@medico1.pacientes).not_to include(@paciente1)
        end

    end

    context "Métodos de la clase " do

        it "Se debe devolver una cadena con la información del médico y el número de pacientes" do
            @medico1.pacientes << @paciente1
            @medico1.pacientes << @paciente2
            expect(@medico1.to_s).to eq("Alba Perez, ID: 12345, Sexo: F, Fecha de Nacimiento: 10/5/1980, Especialidad: Pediatría, Número de Pacientes: 2")
        end
    
        it "Se debe devolver la información correctamente cuando no hay pacientes asignados" do
            expect(@medico1.to_s).to eq("Alba Perez, ID: 12345, Sexo: F, Fecha de Nacimiento: 10/5/1980, Especialidad: Pediatría, Número de Pacientes: 0")
        end

        it "Se espera que el número de pacientes de un médico sea 0 inicialmente" do
            expect(@medico1.numero_pacientes).to eq(0)
            expect(@medico2.numero_pacientes).to eq(0)
        end
        
        it "Se debe poder agregar pacientes a un médico y que la cuenta sea correcta " do
            @medico1.pacientes << @paciente1
            @medico1.pacientes << @paciente2
            expect(@medico1.numero_pacientes).to eq(2)
        end

        it "Se debe poder agregar pacientes a un médico y que la cuenta sea correcta " do
            @medico1.pacientes << @paciente1
            @medico1.pacientes.delete(@paciente2)
            expect(@medico1.numero_pacientes).not_to eq(2)
        end
    end

    context "Métodos públicos de la clase medico" do

        it "Se espera poder verificar los métodos públicos en medico" do
            expect(@persona.public_methods).to include(:to_s)
            expect(@persona.public_methods).to include(:==)
            expect(@persona.public_methods).to include(:instance_of?)
            expect(@persona.public_methods).to include(:equal?)
            expect(ServicioSanitario::Medico.public_instance_methods).to include(:numero_pacientes)
        end

    end

    context "Igualdad de objetos" do 
        it "Se espera que dos medicos con la misma información no sean el mismo objeto usando equal?" do
            expect(@medico1).not_to equal(@medico3)
        end

        it "Se espera verificar la igualdad utilizando ==" do
            expect(@medico1).to eq(@medico4)
        end

        it "Se espera verificar la igualdad utilizando eql?" do
            expect(@medico1).to eql(@medico4)
        end

        it "Se espera verificar que los objetos con la misma referencia son iguales utilizando equal?" do
            expect(@medico1).to equal(@medico4)
        end

        it "Se espera verificar que dos objetos con atributos iguales pero diferente referencia no son iguales utilizando equal?" do
            expect(@medico1).not_to equal(@medico3)
        end

        it "Se espera verificar la igualdad usando === " do
            expect(@medico1 === @medico3).to be true 
        end
    end

    context "Igualdad de objetos (COMPRABLE)" do
        it "Se espera que una fecha incluye el módulo Comparable" do 
            expect(ServicioSanitario::Medico.included_modules).to include(Comparable)
            expect(@medico1.is_a?(Module)).to be(false)
            expect(@medico1).to be_a(Comparable)
        end 

        it "Se espera que la herencia sea correcta" do 
            expect(Comparable.class).to eq(Module)
            expect(Module.superclass).to eq(Object)
            expect(Object.superclass).to eq(BasicObject)
        end  
        it "Se espera que los médicos con el mismo número de pacientes sean iguales" do
            @medico1.pacientes << @paciente1
            @medico3.pacientes << @paciente1
            expect(@medico1 == @medico3).to be true  # Mismo número de pacientes
        end

        it "Se espera que el médico con menos pacientes sea considerado menor" do
            @medico1.pacientes << @paciente1
            @medico2.pacientes << @paciente2
            @medico1.pacientes << @paciente1
            expect(@medico2 < @medico1).to be true  # Médico 2 tiene 1 paciente, médico 1 tiene 2
        end

            it "Se espera que el médico con más pacientes sea considerado mayor" do
            @medico1.pacientes << @paciente1
            @medico1.pacientes << @paciente2
            expect(@medico1 > @medico2).to be true  # Médico 1 tiene 2 pacientes, médico 2 tiene 1
        end

        it "Se espera que el médico con el mismo número de pacientes sea considerado igual" do
            @medico1.pacientes << @paciente1
            @medico1.pacientes << @paciente2
            expect(@medico1 == @medico4).to be true  # Ambos médicos tienen 2 pacientes
        end

        it "Se espera que el médico con el mismo número de pacientes sea considerado mayor o igual" do
            @medico1.pacientes << @paciente1
            @medico1.pacientes << @paciente2
            expect(@medico1 >= @medico4).to be true  # Ambos médicos tienen 2 pacientes
        end

        it "Se espera que el médico con menos pacientes sea considerado menor o igual" do
            @medico2.pacientes << @paciente2
            expect(@medico1 <= @medico2).to be true  # Médico 2 tiene 1 paciente, médico 1 tiene 2
        end
    end

    context "Recorrer objetos (ENUMERABLE)" do
        it "Se espera que una fecha incluye el módulo Enumerable" do 
          expect(ServicioSanitario::Medico.included_modules).to include(Enumerable)
          expect(@medico1.is_a?(Module)).to be(false)
          expect(@medico1).to be_a(Enumerable) 
        end 
    
        it "Se espera que la herencia sea correcta" do 
          expect(Enumerable.class).to eq(Module)
          expect(Module.superclass).to eq(Object)
          expect(Object.superclass).to eq(BasicObject)
        end  

        it "debe iterar sobre los atributos del médico, incluyendo los pacientes" do
            atributos = []
            @medico1.pacientes << @paciente1
            @medico1.each { |attr| atributos << attr }
            expect(atributos).to contain_exactly("12345", "Alba Perez", "F", @fecha1, "Pediatría", 1)  # Uno de los médicos tiene un paciente
        end
    
        it "debe mapear los atributos del médico a una lista de strings" do
            @medico1.pacientes << @paciente1
            atributos = @medico1.map { |attr| attr.to_s }
            expect(atributos).to eq(["12345", "Alba Perez", "F", "10/5/1980", "Pediatría", "1", "Maria Gomez, ID: 54321, Sexo: F, Fecha de Nacimiento: 10/5/1980, Prioridad: {:nivel=>:II, :categoria=>:Emergencia, :tiempo_atencion=>\"7 minutos\"}, Diagnósticos: "])
        end
    
        it "debe seleccionar los atributos que sean cadenas" do
            @medico1.pacientes << @paciente1
            atributos = @medico1.select { |attr| attr.is_a?(String) }
            expect(atributos).to eq(["12345", "Alba Perez", "F", "Pediatría"])
        end
    
        it "debe rechazar los atributos que no sean cadenas" do
            atributos = @medico1.reject { |attr| attr.is_a?(String) }
            expect(atributos).to eq([@fecha1, 0])  # La fecha y el número de pacientes
        end
    
        it "debe encontrar un atributo específico del médico" do
            atributo = @medico1.find { |attr| attr == "Pediatría" }
            expect(atributo).to eq("Pediatría")
        end
    
        it "debe devolver true si algún atributo cumple con la condición" do
            resultado = @medico1.any? { |attr| attr == "Pediatría" }
            expect(resultado).to be true
        end
    
        it "debe tener la cantidad correcta de pacientes después de agregar pacientes" do
            @medico1.pacientes << @paciente1
            @medico2.pacientes << @paciente1
            expect(@medico1.numero_pacientes).to eq(1)
            expect(@medico2.numero_pacientes).to eq(1)
        end

        it "debe iterar sobre los atributos del médico, incluyendo los pacientes" do
            atributos = []
            @medico1.each { |attr| atributos << attr }
            expect(atributos).to contain_exactly(
              "12345", "Alba Perez", "F", @fecha1, "Pediatría", 1, @paciente1
            )  # Incluye los pacientes también
        end
    end 
end 
