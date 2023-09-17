## Data structure to use in the simulations
#=```
The Lennard-Jones potential is given by the following equation:

V(r) = 4ε[(σ/r)^12 - (σ/r)^6]

where r is the distance between the two particles, ε is the depth of the potential well, and σ is the distance at which the potential is zero.
The first term in the equation represents the repulsive part of the potential, which arises from the Pauli exclusion principle that prevents the atoms from occupying the same space. The second term represents the attractive part of the potential,
which arises from the van der Waals forces between the atoms or molecules.

The shape of the Lennard-Jones potential is such that it has a minimum at a certain distance between the two particles, corresponding to the equilibrium distance at which the attractive and repulsive forces balance each other.
At this distance, the potential energy is negative, indicating that the two particles are bound together by the attractive forces. However, at shorter distances, the repulsive forces become dominant, leading to a steep increase in the potential energy.
At longer distances, the attractive forces become weaker, leading to a gradual decrease in the potential energy.


Atom   ϵ(1.388 10e-23 J = k_b)     σ(10^-1 nm = 1 Å)
 H          8.6                       2.81 
 He        10.2                       2.28
 Ar       119.8                       3.41
 Kr       164.0                       3.83



```=#
@with_kw struct Data

	# particle data
	eps ::  Float64  = 6.5
	sig ::  Float64  = 1.2
	mass :: Float64  = 6.0

	# box side and cutoff information
	cutoff :: Float64   = 3.5
	side   :: Float64   = 250.

	# number of particles
	N :: Int64 = 200

	# density
	rho :: Float64 = 1.00
	
	# Data for computation of ljpair
	eps4 :: Float64  = 4*eps
	sig6 :: Float64  = sig^6
	sig12 :: Float64 = sig^12

end


@with_kw struct Data_mix

	# particle1 data
	eps1 ::  Float64  = 6.5
	sig1 ::  Float64  = 1.2
	mass1 :: Float64  = 6.0

    # particle2 data
	eps2 ::  Float64  = 6.5
	sig2 ::  Float64  = 1.2
	mass2 :: Float64  = 6.0

    #mixing rule - Lorentz-Berthelot
    σ12  = 0.5*(sig1 + sig2) 
    ϵ12  = sqrt(eps1 + eps2)

	# box side and cutoff information
	cutoff :: Float64   = 3.5
	side   :: Float64   = 250.

	# number of particles
	N1 :: Int64 = 200
    N2 :: Int64 = 100
	# density

	rho :: Float64 = 1.00
	
	# Data for computation of ljpair
	eps4 :: Float64  = 4*eps
	sig6 :: Float64  = sig^6
	sig12 :: Float64 = sig^12

end



# struct to define the MD parameters
@with_kw struct MDinput

    temp       :: Float64 = 298.15 # K
    total_time :: Float64 = 10     # to be defined
    dt         :: Float64 = 0.01   # timestep / unit to be defined
    nsteps     :: Int64   = trunc(Int64,total_time / dt) # total simulastions time
    iprint     :: Int64   = 10     # print at each 10 steps
  
  end