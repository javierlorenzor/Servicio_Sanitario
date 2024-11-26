require 'spec_helper'
require 'ServicioSanitario/ServicioSalud'
require 'ServicioSanitario'
require 'ServicioSanitario/Hospital'

RSpec.describe ServicioSanitario::Hospital do

    before(:each) do
        # Bloque `before` proporcionado por el usuario.
        @fecha1 = ServicioSanitario::Fecha.new(dia: 19, mes: 7, anio: 2001)
        @fecha2 = ServicioSanitario::Fecha.new(dia: 23, mes: 9, anio: 2004)
        @dia_festivo1 = ServicioSanitario::Fecha.new(dia: 25, mes: 12, anio: 2024)
        @dia_festivo2 = ServicioSanitario::Fecha.new(dia: 1, mes: 1, anio: 2025)
    
        @horario_apertura = ServicioSanitario::Hora.new(hora: 8, minuto: 0, segundo: 0)
        @horario_cierre = ServicioSanitario::Hora.new(hora: 20, minuto: 0, segundo: 0)
        @paciente1 = ServicioSanitario::Persona.new("11111", "Carlos", "López", "M", @fecha1)
        @paciente2 = ServicioSanitario::Persona.new("22222", "Lucía", "Martínez", "F", @fecha2)
        @medico1 = ServicioSanitario::Medico.new("33333", "Alba", "Perez", "F", @fecha1, "Pediatría")
        @medico2 = ServicioSanitario::Medico.new("44444", "Miguel", "Tadeo", "M", @fecha2, "Pediatría")
        @medico2.pacientes << @paciente1
        @camas = { 1 => nil, 2 => nil, 3 => nil }
    
        @hospital = ServicioSanitario::Hospital.new(
          codigo: "HOSP001",
          descripcion: "Hospital General",
          horario_apertura: @horario_apertura,
          horario_cierre: @horario_cierre,
          dias_festivos: [@dia_festivo1, @dia_festivo2],
          medicos: [@medico1, @medico2],
          camas: @camas,
          numero_plantas: 4
        )
        @hospital2 = ServicioSanitario::Hospital.new(
            codigo: "HOSP002",
            descripcion: "Hospital Especializado",
            horario_apertura: @horario_apertura,
            horario_cierre: @horario_cierre,
            dias_festivos: [@dia_festivo1],
            medicos: [@medico1],
            camas: { 1 => nil, 2 => nil }, 
            numero_plantas: 6
        )
    end

    context "Inicialización de atributos , to_s y herencia" do
        it "Se espera poder crear una instancia de ServicioSalud" do
          expect(ServicioSanitario::Hospital).not_to be_nil
        end

        it "Se espera que la instancia pertenezca a la clase determinada" do
            expect(@hospital).to be_a(ServicioSanitario::Hospital)
            expect(@hospital).to be_a(Object)
            expect(@hospital.instance_of?(ServicioSanitario::Hospital)).to be true
            expect(ServicioSanitario::Hospital.superclass).to eq(ServicioSanitario::ServicioSalud)
            expect(ServicioSanitario::ServicioSalud.superclass).to eq(Object)
            expect(Object.superclass).to eq(BasicObject)
        end

        it "Se espera que se inicialicen correctamente un hospital con los parámetros dados" do
            expect(@hospital.codigo).to eq("HOSP001")
            expect(@hospital.descripcion).to eq("Hospital General")
            expect(@hospital.horario_apertura).to eq(@horario_apertura)
            expect(@hospital.horario_cierre).to eq(@horario_cierre)
            expect(@hospital.dias_festivos).to contain_exactly(@dia_festivo1, @dia_festivo2)
            expect(@hospital.medicos).to contain_exactly(@medico1, @medico2)
            expect(@hospital.camas).to eq(@camas)
            expect(@hospital.numero_plantas).to eq(4)
          end
      
          it "Se espera que lance un error si faltan parámetros obligatorios" do
            expect {
              ServicioSanitario::Hospital.new(
                codigo: "HOSP002",
                descripcion: "Hospital Incompleto",
                horario_apertura: @horario_apertura,
                horario_cierre: @horario_cierre,
                dias_festivos: [@dia_festivo1],
                medicos: [@medico1],
                camas: @camas
                # Falta el número de plantas
              )
            }.to raise_error(ArgumentError)
          end

        it "devuelve una representación en cadena del hospital" do
            expected_output = <<~OUTPUT
              Código: HOSP001
              Descripción: Hospital General
              Horario: 08:00:00 - 20:00:00
              Días Festivos: 25/12/2024, 1/1/2025
              Camas Libres: 3
              Total de Pacientes Asignados a Médicos: 1
              Número de Plantas: 4
            OUTPUT
          
            expect(@hospital.to_s).to eq(expected_output.strip)
          end
      


        it "Se espera que la salida del to_s sea un string" do 
            expect(@hospital.to_s).to be_a(String)
        end 
    end 

    context "Modulo COMPARABLE" do 
        it "Se espera que una fecha incluye el módulo Comparable" do 
            expect(ServicioSanitario::Hospital.included_modules).to include(Comparable)
            expect(@hospital.is_a?(Module)).to be(false)
            expect(@hospital).to be_a(Comparable)
            expect(@hospital).not_to be_a(Enumerable)
        end 

        it "Se espera que la herencia sea correcta" do 
            expect(Comparable.class).to eq(Module)
            expect(Module.superclass).to eq(Object)
            expect(Object.superclass).to eq(BasicObject)
        end  

        it "Se espera comparar correctamente con <" do
            expect(@hospital2 < @hospital).to be true
        end
        
        it "Se espera comparar correctamente con >" do
            expect(@hospital > @hospital2).to be true
        end
        
        it "Se espera comparar correctamente con <=" do
            expect(@hospital2 <= @hospital).to be true
            expect(@hospital <= @hospital).to be true
        end
        
        it "Se espera comparar correctamente con >=" do
            expect(@hospital >= @hospital2).to be true
            expect(@hospital >= @hospital).to be true
        end
        
        it "Se espera comparar correctamente con ==" do
            expect(@hospital == @hospital2).to be false
            expect(@hospital == @hospital).to be true
        end
        
        it "Se espera verificar si está en un rango con between?" do
            expect(@hospital.between?(@hospital2, @hospital)).to be true
            expect(@hospital2.between?(@hospital, @hospital2)).to be false
        end
    end 

    context "POLIMORFISMO" do
      it "Se espera responder a los métodos de la clase base ServicioSalud" do
        expect(@hospital).to respond_to(:codigo) 
        expect(@hospital).to respond_to(:descripcion) 
        expect(@hospital).to respond_to(:horario_apertura) 
        expect(@hospital).to respond_to(:horario_cierre) 
        expect(@hospital).to respond_to(:num_camas_libres) 
        expect(@hospital).to respond_to(:to_s)
        expect(@hospital).to respond_to(:asignar_cama)
        expect(@hospital).to respond_to(:liberar_cama)
      end
  
      it "Se espera sobrescribir correctamente el método to_s" do
        expect(@hospital.to_s).to include("Código: HOSP001")
        expect(@hospital.to_s).to include("Número de Plantas: 4")
      end
  
      it "Se espera implementar el método <=> para comparar hospitales" do
        expect(@hospital <=> @hospital2).to eq(1) 
      end
  
      it "Se espera responder a métodos específicos de la subclase Hospital" do
        expect(@hospital).to respond_to(:numero_plantas)
      end

      it "Se espera calcular correctamente el número de camas libres" do
        expect(@hospital.num_camas_libres).to eq(3)
        @hospital.asignar_cama(@paciente1)
        expect(@hospital.num_camas_libres).to eq(2)
      end
  
      it "Se espera poder asignar camas y liberar camas correctamente" do
        cama_asignada = @hospital.asignar_cama(@paciente1)
        expect(cama_asignada).not_to be_nil
        expect(@hospital.num_camas_libres).to eq(2)
        expect(@hospital.liberar_cama(cama_asignada)).to eq(true)
        expect(@hospital.num_camas_libres).to eq(3)
      end
  
      it "Se espera que sobrescriba correctamente el operador de comparación (<=>)" do
        expect(@hospital <=> @hospital2).to eq(1)
      end
    end 
end 