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
        @paciente4 = @paciente1
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
        end
    end

    context "Pruebas getters" do
        
        it "Se espera que se devuelva el valor esperado " do
            expect(@paciente1.numero_identificacion).to eq("12345")
            expect(@paciente2.numero_identificacion).to eq("67890")
            expect(@paciente1.nombre).to eq("Juan")
            expect(@paciente1.apellido).to eq("Pérez")
            expect(@paciente1.sexo).to eq("M")
            expect(@paciente1.fecha_nacimiento).to eq(@fecha1)
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

        it "Se espera verificar que === no se usa comúnmente para la comparación de objetos directos" do
            expect(@paciente1 === @paciente3).to be false
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

    context "Métodos públicos de la clase Persona" do
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
end
