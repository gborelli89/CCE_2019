# --------------------------------------------------------------------
# Cálculo teórico regime permanente
# --------------------------------------------------------------------
# a: condição de contorno para x=0
# b: condição de contorno para x=1
# x: ponto de cálculo
# --------------------------------------------------------------------
steady1D <- function(a,b,x){
	u <- (b-a)*x + a
	return(u)
}

calcFo <- function(alpha, dt, dx){
	Fo <- alpha*dt/(dx^2)
	return(Fo)
}

computeMesh <- function(a, b, mid, dx){
	x <- seq(0,1,by=dx)
	nx <- length(x)
	uinit <- c(a, rep(mid,(nx-2)), b)
	mesh <- cbind(x, uinit)
	return(mesh)
}

# valores para Fo=1/2 => alpha=1e-4; dt=50, dx=0.1
eulerExplicito <- function(a, b, mid, dx,dt, alpha, steps){
	mesh <- computeMesh(a=a,b=b,mid=mid, dx=dx)
	u <- cbind(mesh[,2])
	U <- u
	Fo <- calcFo(alpha=alpha, dt=dt, dx=dx)
	nx <- dim(mesh)[1]
	nn <- nx-2
	Mdiff <- toeplitz(c(-2,1,rep(0,nn)))
	Mdiff[1,] <- 0
	Mdiff[nx,] <- 0
	for(i in 1:steps){
		u <- u + Fo*(Mdiff%*%u)
		U <- cbind(U, u)
	}
	return(U)
}

puloSapo <- function(a, b, mid, dx,dt, alpha, steps){
	Fo <- calcFo(alpha=alpha, dt=dt, dx=dx)
	U <- eulerExplicito(a=a,b=b,mid=mid,dx=dx,dt=dt,alpha=alpha,steps=1)
	nx <- dim(U)[1]
	nn <- nx-2
	Mdiff <- toeplitz(c(-2,1,rep(0,nn)))
	Mdiff[1,] <- 0
	Mdiff[nx,] <- 0	
	for(i in 2:steps){
		k <- i-1
		u <- U[,k] + 2*Fo*(Mdiff%*%cbind(U[,i]))
		U <- cbind(U,u)
	}
	return(U)	
}

