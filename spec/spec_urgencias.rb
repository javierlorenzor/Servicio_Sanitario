require 'spec_helper'
require 'ServicioSanitario/ServicioSalud'
require 'ServicioSanitario'
require 'ServicioSanitario/Urgencias'

RSpec.describe ServicioSanitario::Urgencias do

    before(:each) do
        # Instancias de Fecha
        @fecha1 = ServicioSanitario::Fecha.new(dia: 19, mes: 7, anio: 2001)
        @fecha2 = ServicioSanitario::Fecha.new(dia: 23, mes: 9, anio: 2004)
        @dia_festivo1 = ServicioSanitario::Fecha.new(dia: 25, mes: 12, anio: 2024)
        @dia_festivo2 = ServicioSanitario::Fecha.new(dia: 1, mes: 1, anio: 2025)
    
        # Instancias de Hora
        @horario_apertura = ServicioSanitario::Hora.new(hora: 8, minuto: 0, segundo: 0)
        @horario_cierre = ServicioSanitario::Hora.new(hora: 20, minuto: 0, segundo: 0)
        @hora2 = ServicioSanitario::Hora.new(hora: 10, minuto: 40, segundo: 25)
        @hora3 = ServicioSanitario::Hora.new(hora: 14, minuto: 50, segundo: 15)
    
        # Instancias de Persona y Médico
        @paciente1 = ServicioSanitario::Persona.new("11111", "Carlos", "López", "M", @fecha1)
        @paciente2 = ServicioSanitario::Persona.new("22222", "Lucía", "Martínez", "F", @fecha2)
    
        @medico1 = ServicioSanitario::Medico.new("33333", "Alba", "Perez", "F", @fecha1, "Pediatría")
        @medico2 = ServicioSanitario::Medico.new("44444", "Miguel", "Tadeo", "M", @fecha2, "Pediatría")
    
        # Asignación de paciente a médico
        @medico2.pacientes << @paciente1
    
        # Configuración de camas para el servicio
        @camas = { 1 => nil, 2 => nil, 3 => nil }
    
        # Crear un servicio de urgencias
        @urgencias = ServicioSanitario::Urgencias.new(
          codigo: "URG001",
          descripcion: "Urgencias Generales",
          horario_apertura: @horario_apertura,
          horario_cierre: @horario_cierre,
          dias_festivos: [@dia_festivo1, @dia_festivo2],
          medicos: [@medico1, @medico2],
          camas: @camas,
          camas_uci: 5  # Asumimos que hay 5 camas UCI
        )
        @urgencias1 = ServicioSanitario::Urgencias.new(
            codigo: "URG002",
            descripcion: "Urgencias Especializadas",
            horario_apertura: @horario_apertura,
            horario_cierre: @horario_cierre,
            dias_festivos: [@dia_festivo1],
            medicos: [@medico1],
            camas: @camas,
            camas_uci: 3
        )
        
    end
    
    context "Inicialización , herencia y to_s " do
        it "Se espera poder crear una instancia de ServicioSalud" do
          expect(@urgencias).not_to be_nil
        end

        it "Se espera poder inicializar correctamente las propiedades del servicio de urgencias" do
            expect(@urgencias.codigo).to eq("URG001")
            expect(@urgencias.descripcion).to eq("Urgencias Generales")
            expect(@urgencias.horario_apertura).to eq(@horario_apertura)
            expect(@urgencias.horario_cierre).to eq(@horario_cierre)
            expect(@urgencias.dias_festivos).to include(@dia_festivo1, @dia_festivo2)
            expect(@urgencias.medicos).to include(@medico1, @medico2)
            expect(@urgencias.camas).to eq(@camas)
            expect(@urgencias.camas_uci).to eq(5)
        end

        it "Se espera que la instancia pertenezca a la clase determinada" do
            expect(@urgencias).to be_a(ServicioSanitario::Urgencias)
            expect(@urgencias).to be_a(Object)
            expect(@urgencias.instance_of?(ServicioSanitario::Urgencias)).to be true
            expect(ServicioSanitario::Urgencias.superclass).to eq(ServicioSanitario::ServicioSalud)
            expect(ServicioSanitario::ServicioSalud.superclass).to eq(Object)
            expect(Object.superclass).to eq(BasicObject)
        end

        it "Se espera devolver una representación en cadena de Urgencias correctamente" do
            expected_output = <<~INFO
                Código: URG001
                Descripción: Urgencias Generales
                Horario: #{@horario_apertura} - #{@horario_cierre}
                Días Festivos: #{@dia_festivo1.to_s}, #{@dia_festivo2.to_s}
                Camas Libres: 3
                Total de Pacientes Asignados a Médicos: 1
                Camas UCI Disponibles:5
            INFO
            expect(@urgencias.to_s).to eq(expected_output)
        end

    end

    context "Modulo COMPARABLE" do 
        it "Se espera que una fecha incluye el módulo Comparable" do 
            expect(ServicioSanitario::Urgencias.included_modules).to include(Comparable)
            expect(@urgencias.is_a?(Module)).to be(false)
            expect(@urgencias).to be_a(Comparable)
            expect(@urgencias).not_to be_a(Enumerable)
        end 

        it "Se espera que la herencia sea correcta" do 
            expect(Comparable.class).to eq(Module)
            expect(Module.superclass).to eq(Object)
            expect(Object.superclass).to eq(BasicObject)
        end  

        it "Se espera poder comparar servicios con <=>" do
            expect(@urgencias <=> @urgencias1).to eq(1)  
        end
        
        it "Se espera poder comparar usando la igualdad  <" do
            expect(@urgencias < @urgencias1).to be false
        end
        
        it "Se espera poder comparar usando la igualdad  >" do
            expect(@urgencias > @urgencias1).to be true
        end
        
        it "Se espera poder comparar usando la igualdad  <=" do
            expect(@urgencias1 <= @urgencias).to be true
        end
        
        it "Se espera poder comparar usando la igualdad  >=" do
            expect(@urgencias1 >= @urgencias).to be false
        end
        
        it "Se espera poder comparar usando la igualdad  ==" do
            expect(@urgencias == @urgencias1).to be false
        end
        
        it "Se espera poder comparar usando la igualdad  between?" do
            expect(@urgencias.camas_uci).to be_between(3, 5).inclusive
        end
         
    end 

    context "polimorfismo" do
        it "responde a los métodos de la clase base ServicioSalud" do
            expect(@urgencias).to respond_to(:codigo) 
            expect(@urgencias).to respond_to(:to_s)
            expect(@urgencias).to respond_to(:descripcion)
            expect(@urgencias).to respond_to(:horario_apertura)
            expect(@urgencias).to respond_to(:horario_cierre)
            expect(@urgencias).to respond_to(:num_camas_libres)
            expect(@urgencias).to respond_to(:asignar_cama)
            expect(@urgencias).to respond_to(:liberar_cama)
        end
    
        it "sobrescribe correctamente el método to_s" do
            expect(@urgencias.to_s).to include("Código: URG001")
            expect(@urgencias.to_s).to include("Descripción: Urgencias Generales")
        end
    
        it "implementa el método <=> para comparar urgencias" do
            expect(@urgencias <=> @urgencias1).to eq(1) # @urgencias tiene más camas libres
        end
    
        it "responde a métodos específicos de la subclase Urgencia" do
            expect(@urgencias).to respond_to(:camas_uci)
            
        end
      
      
        it "calcula correctamente el número de camas libres" do
            expect(@urgencias.num_camas_libres).to eq(3)
            @urgencias.asignar_cama("Paciente crítico")
            expect(@urgencias.num_camas_libres).to eq(2)
        end
      
        it "puede asignar camas y liberar camas correctamente" do
            cama_asignada = @urgencias.asignar_cama("Paciente crítico")
            expect(cama_asignada).not_to be_nil
            expect(@urgencias.num_camas_libres).to eq(2)
            expect(@urgencias.liberar_cama(cama_asignada)).to eq(true)
            expect(@urgencias.num_camas_libres).to eq(3)
        end
      
        it "sobrescribe correctamente el operador de comparación (<=>)" do
            expect(@urgencias <=> @urgencias1).to eq(1) # @urgencias tiene más camas libres
        end
      
        it "funciona en colecciones polimórficas" do
            lista_urgencias = [@urgencias1, @urgencias]
            expect(lista_urgencias.sort).to eq([@urgencias1, @urgencias]) # Ordenadas por número de camas libres
        end
       
    end


end 
