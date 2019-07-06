
fluidPage(

  titlePanel("Heat Transfer - 1D transient"),

  sidebarPanel(
	
	selectInput('method','Method', choices=c('Euler forward'=1,'Leapfrog'=2), selected=1), 
	
	numericInput('alpha', 'Thermal diffusivity', value=1e-4),
	
	
	fluidRow(
		column(6,
			numericInput('a', 'Left temperature BC', value=10)
		),
		
		column(6,
			numericInput('b', 'Right temperature BC', value=0)
		)
	),
	
	numericInput('mid', 'Middle temperature (initial condition)', value=0),
	numericInput('dx', 'Delta x', value=0.1),
	
	
	h5(tags$b("Timestep parameters")),
	
	fluidRow(
		column(4,
			numericInput('dtmin', 'min', value=10)
		),

		column(4,
			numericInput('dtmax', 'max', value=60)
		),
		column(4,
			numericInput('dtres', 'resolution', value=1)
		)
	),
	
	uiOutput("timestep"),
	
	h5(tags$b("Fourier number")),
	textOutput("Fo")
	
  ),

  mainPanel(

	fluidRow(
		column(6,
			sliderInput('steps', 'Number of steps', min=100, max=1000, value=100, step=100)
		),
		column(6,
			numericInput('node', 'Node', value=6)
		)
	),
	
    plotOutput('plot')
  )
)