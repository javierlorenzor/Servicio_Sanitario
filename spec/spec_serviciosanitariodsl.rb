require 'rspec'
require 'spec_helper'
require 'ServicioSanitario/ServicioSalud'
require 'ServicioSanitario/Hospital'
require 'ServicioSanitario/Paciente'
require 'ServicioSanitario/Medico'
require 'ServicioSanitario/ServicioSanitarioDSL'
require 'ServicioSanitario'

describe ServicioSanitario::ServicioSanitarioDSL do
  before(:each) do
    @sistema = ServicioSanitario::ServicioSanitarioDSL.new do
    
      # Se definen los servicios
      servicio :hospital, 
        codigo: 'CIF012345678', 
        descripcion: 'Hospital LPP', 
        horario_apertura: ServicioSanitario::Hora.new(hora: 5, minuto: 0, segundo: 0), 
        horario_cierre: ServicioSanitario::Hora.new(hora: 22, minuto: 0, segundo: 0), 
        dias_festivos: [ServicioSanitario::Fecha.new(dia: 1, mes: 12, anio: 2024)], 
        medicos: ['Dr.Poo', 'Dr.Fup'], 
        camas: {1 => 'ocupado', 2 => nil}, 
        numero_plantas: 5

      servicio :servicio, 
        codigo: 'CIF876543210', 
        descripcion: 'Urgencias LPP', 
        horario_apertura: ServicioSanitario::Hora.new(hora: 0, minuto: 0, segundo: 0), 
        horario_cierre: ServicioSanitario::Hora.new(hora: 24, minuto: 0, segundo: 0), 
        dias_festivos: [], 
        medicos: ['Dr.Struct', 'Dr.Single'], 
        camas: {1 => 'ocupado'}

      # Se definen los MEDICOS 
      usuario :medico, 
        numero_identificacion: 2005001, 
        nombre: 'Dr.', 
        apellido: 'Poo', 
        sexo: 'mujer', 
        fecha_nacimiento: ServicioSanitario::Fecha.new(dia: 1, mes: 1, anio: 1990), 
        especialidad: 'geriatría'
      
        usuario :medico, 
        numero_identificacion: 2005002, 
        nombre: 'Dr.', 
        apellido: 'Fup', 
        sexo: 'hombre', 
        fecha_nacimiento: ServicioSanitario::Fecha.new(dia: 1, mes: 1, anio: 1995), 
        especialidad: 'general'

      usuario :medico, 
        numero_identificacion: 2005003, 
        nombre: 'Dr.', 
        apellido: 'Struct', 
        sexo: 'mujer', 
        fecha_nacimiento: ServicioSanitario::Fecha.new(dia: 1, mes: 1, anio: 1980), 
        especialidad: 'pediatría'

      usuario :medico, 
        numero_identificacion: 2005004, 
        nombre: 'Dr.', 
        apellido: 'Single', 
        sexo: 'hombre', 
        fecha_nacimiento: ServicioSanitario::Fecha.new(dia: 1, mes: 1, anio: 1975), 
        especialidad: 'general'

      # Se definen los PACIENTES
      usuario :paciente, 
        numero_identificacion: 2024001, 
        nombre: 'Paciente', 
        apellido: 'Tos', 
        sexo: 'hombre', 
        fecha_nacimiento: ServicioSanitario::Fecha.new(dia: 2, mes: 12, anio: 1935), 
        prioridad: ServicioSanitario::ROJO
        
      usuario :paciente, 
        numero_identificacion: 2024002, 
        nombre: 'Paciente', 
        apellido: 'Caida', 
        sexo: 'mujer', 
        fecha_nacimiento: ServicioSanitario::Fecha.new(dia: 1, mes: 11, anio: 2020), 
        prioridad: ServicioSanitario::ROJO
    end
  end

  context "Initialize y herencia " do
    it "Se espera que se inicialice correctamente el sistema" do
      expect(@sistema.instance_variable_get(:@servicios)).not_to be_empty
      expect(@sistema.instance_variable_get(:@usuarios)).not_to be_empty
    end
    it "Se espera manejar correctamente la herencia de la clase Dsl" do 
      expect(ServicioSanitario::ServicioSanitarioDSL.superclass).to eq(Object)
      expect(Object.superclass).to eq(BasicObject)
      expect(ServicioSanitario::ServicioSanitarioDSL.ancestors).not_to include(Comparable)
      expect(ServicioSanitario::ServicioSanitarioDSL.ancestors).not_to include(Enumerable)
      expect(ServicioSanitario::ServicioSanitarioDSL).not_to be(Comparable)
      expect(ServicioSanitario::ServicioSanitarioDSL).not_to be(Enumerable)
    end
  end 

  context "Pruebas servicios " do
    it "Se espera que se registren los servicios correctamente" do
      servicios = @sistema.instance_variable_get(:@servicios)
      expect(servicios[0].codigo).to eq('CIF012345678')
      expect(servicios[0].descripcion).to eq('Hospital LPP')
      expect(servicios[1].codigo).to eq('CIF876543210')
      expect(servicios[1].descripcion).to eq('Urgencias LPP')
    end

    it "se espera que el numero de servicios sea correcto" do
      servicios = @sistema.instance_variable_get(:@servicios)
      expect(servicios.size).to eq(2)
    end 
  end 
  
  context "Pruebas usuarios " do
    it "Se espera que se pueda registrar usuarios correctamente" do
      usuarios = @sistema.instance_variable_get(:@usuarios)
      expect(usuarios[0].nombre_completo).to eq('Dr. Poo')
      expect(usuarios[1].nombre_completo).to eq('Dr. Fup')
    end
  
    it "Se espera que el numero de usuarios sea correcto" do
      usuarios = @sistema.instance_variable_get(:@usuarios)
      expect(usuarios.size).to eq(6)
    end 
  
    it "Se espera que el numero de medicos sea correcto" do
      medicos = @sistema.instance_variable_get(:@usuarios).select { |usuario| usuario.is_a?(ServicioSanitario::Medico) }
      expect(medicos.size).to eq(4)
    end 
  
    it "Se espera que el numero de pacientes sea correcto" do
      pacientes = @sistema.instance_variable_get(:@usuarios).select { |usuario| usuario.is_a?(ServicioSanitario::Paciente) }
      expect(pacientes.size).to eq(2)
    end
  
    it "Se espera que se pueda registrar un médico correctamente" do
      medico = @sistema.instance_variable_get(:@usuarios)[0]
      expect(medico).to be_a(ServicioSanitario::Medico)
      expect(medico.especialidad).to eq('geriatría')
    end
  
    it "Se espera manejar un error al registrar un usuario con tipo desconocido" do
      expect {
        @sistema.usuario(:desconocido, numero_identificacion: 999, nombre: 'Test', apellido: 'Error', sexo: 'n/a', fecha_nacimiento: ServicioSanitario::Fecha.new(dia: 1, mes: 1, anio: 2000))
      }.to raise_error(ArgumentError, /Tipo de usuario no reconocido/)
    end  
  end 

  context "Pruebas to_s" do 
    it "Se espera que se devuelva la información de los servicios correctamente" do
      servicios = @sistema.instance_variable_get(:@servicios)
      expect(servicios[0].to_s).to eq("Hospital LPP, CIF: CIF012345678, Horario: 05:00:00 - 22:00:00, Días Festivos: [2024-12-01], Médicos: [Dr. Poo, Dr. Fup], Camas: {1 => ocupado, 2 => libre}, Número de Plantas: 5")
      expect(servicios[1].to_s).to eq("Urgencias LPP, CIF: CIF876543210, Horario: 00:00:00 - 24:00:00, Días Festivos: [], Médicos: [Dr. Struct, Dr. Single], Camas: {1 => ocupado}")
    end

    it "Se espera que se devuelva la información de los medicos correctamente" do
      medicos = @sistema.instance_variable_get(:@usuarios).select { |usuario| usuario.is_a?(ServicioSanitario::Medico) }
      
      expect(medicos[0].to_s).to eq("Dr. Poo, ID: 2005001, Sexo: mujer, Fecha de Nacimiento: 1/1/1990, Especialidad: geriatría, Número de Pacientes: 0")
      expect(medicos[1].to_s).to eq("Dr. Fup, ID: 2005002, Sexo: hombre, Fecha de Nacimiento: 1/1/1995, Especialidad: general, Número de Pacientes: 0")
      expect(medicos[2].to_s).to eq("Dr. Struct, ID: 2005003, Sexo: mujer, Fecha de Nacimiento: 1/1/1980, Especialidad: pediatría, Número de Pacientes: 0")
      expect(medicos[3].to_s).to eq("Dr. Single, ID: 2005004, Sexo: hombre, Fecha de Nacimiento: 1/1/1975, Especialidad: general, Número de Pacientes: 0")

    end
    it "Se espera que se devuelva la información de los pacientes correctamente" do
      pacientes = @sistema.instance_variable_get(:@usuarios).select { |usuario| usuario.is_a?(ServicioSanitario::Paciente) }
      
      expect(pacientes[0].to_s).to eq("Paciente Tos, ID: 2024001, Sexo: hombre, Fecha de Nacimiento: 2/12/1935, Prioridad: {:nivel=>:II, :categoria=>:Emergencia, :tiempo_atencion=>\"7 minutos\"}, Diagnósticos: ")
      expect(pacientes[1].to_s).to eq("Paciente Caida, ID: 2024002, Sexo: mujer, Fecha de Nacimiento: 1/11/2020, Prioridad: {:nivel=>:II, :categoria=>:Emergencia, :tiempo_atencion=>\"7 minutos\"}, Diagnósticos: ")
    end
  end 

end