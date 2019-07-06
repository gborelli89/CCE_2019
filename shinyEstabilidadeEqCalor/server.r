source('scripts.r')

function(input, output) {

	output$timestep <- renderUI({
		sliderInput('dt', 'Timestep', min=input$dtmin, max=input$dtmax, value=input$dtmax, step=input$dtres) 
	})
  	
	
	output$Fo <- renderText({
		Fo <- calcFo(input$alpha,input$dt,input$dx)
		print(Fo)
	})
		
	output$plot <- renderPlot({
		
		if(input$method==1){
			U <- eulerExplicito(a=input$a,b=input$b,mid=input$mid,dx=input$dx,dt=input$dt,alpha=input$alpha,steps=input$steps)
		}
		if(input$method==2){
			U <- puloSapo(input$a,input$b,input$mid,input$dx,input$dt,input$alpha,input$steps)
		}
		ux <- ts(U[input$node,], deltat=input$dt, start=0)
		plot(ux, ylab='u(node)')
		grid()
	}, height=500)

}