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
        @medico1 = ServicioSanitario::Medico.new("12345", "Alba", "Perez", "F", @fecha1, "Pediatría")
        @fecha2 = ServicioSanitario::Fecha.new(dia: 10, mes: 5, anio: 1980)
        @medico2 = ServicioSanitario::Medico.new("56789", "Miguel", "Tadeo", "M", @fecha2, "Pediatría")
        @paciente1 = ServicioSanitario::Paciente.new("54321", "Maria", "Gomez", "F", @fecha1, ServicioSanitario::ROJO)
        @paciente2 = ServicioSanitario::Paciente.new("67890", "Carlos", "Ruiz", "M", @fecha2, ServicioSanitario::AZUL)
    end

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
    end

    it "Se debe inicializar con los atributos correctos" do
        expect(@medico2.numero_identificacion).to eq("56789")
        expect(@medico2.nombre).to eq("Miguel")
        expect(@medico2.apellido).to eq("Tadeo")
        expect(@medico2.sexo).to eq("M")
        expect(@medico2.fecha_nacimiento).to eq(@fecha2)
        expect(@medico2.especialidad).to eq("Pediatría")
        expect(@medico2.pacientes).to be_empty
    end

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
