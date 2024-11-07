# ServicioSanitario
# Estructura del Proyecto

```plaintext
.
├── doc  
├── Gemfile
├── Gemfile.lock
├── lib
│   ├── ServicioSanitario
│   │   ├── Fecha.rb
│   │   ├── Horas.rb
│   │   ├── NivelSet.rb
│   │   └── version.rb
│   └── ServicioSanitario.rb
├── Rakefile
├── README.md
├── ServicioSanitario.gemspec
├── sig
│   └── ServicioSanitario.rbs
└── spec
    ├── ServicioSanitario_spec.rb
    ├── spec_fecha.rb
    ├── spec_helper.rb
    ├── spec_horas.rb
    └── spec_nivelset.rb
```


## Descripción de carpetas y archivos principales

- **`doc/`**: Carpeta generada por YARD que contiene la documentación HTML del proyecto.
- **`lib/`**: Contiene el código fuente del proyecto.
  - **`ServicioSanitario/`**: Módulo que contiene las clases 
        - `Fecha`, `Horas`, `NivelSet`
  - **`ServicioSanitario.rb`**: Archivo principal que carga el módulo `ServicioSanitario`.
- **`spec/`**: Carpeta de pruebas que incluye archivos de pruebas RSpec para cada clase.
  - **`spec_helper.rb`**: Configuración común para todas las pruebas.
- **`Gemfile` y `Gemfile.lock`**: Listan las dependencias del proyecto.
- **`Rakefile`**: Archivo para tareas automatizadas de Rake.
- **`README.md`**: Archivo de documentación principal del proyecto.
- **`ServicioSanitario.gemspec`**: Especificación de la gema `ServicioSanitario`.

## Proyect
La gema **ServicioSanitario** implementa un sistema de triaje estructurado, utilizado para priorizar la atención de pacientes según la gravedad y urgencia de sus necesidades. El proceso de "triaje" permite una gestión eficaz del riesgo clínico en situaciones donde la demanda médica supera los recursos disponibles. Para lograr esto, se basa en escalas de prioridad que clasifican a los pacientes en varios niveles de atención.

## Usage

El archivo Rakefile en la raíz del proyecto permite la ejecución de tareas automáticas, como la generación de documentación o la ejecución de pruebas. Este archivo está configurado para simplificar los flujos de trabajo, proporcionando comandos predefinidos que pueden invocarse fácilmente desde la terminal. Para la ejecución usar **rake** 

## Development

La gema sigue el enfoque de desarrollo orientado a pruebas **(TDD: Test Driven Development)**, donde las pruebas se crean antes de la implementación de las funcionalidades. Esto garantiza que cada parte del código cumpla con los requisitos definidos y ayuda a detectar errores desde las primeras etapas del desarrollo

# Documentación 

La documentación de esta gema se genera con **YARD**, una herramienta para documentar código Ruby de manera estructurada y fácil de entender. Usando YARD, se crean comentarios detallados en el código que luego se convierten en documentación HTML navegable. Esto facilita el acceso a la información sobre las clases, métodos y constantes, permitiendo a los desarrolladores comprender y usar la gema de manera más efectiva.


