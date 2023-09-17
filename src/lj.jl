function ljpair(r::Float64, data::Data)
    r6 = r⁶
    r12 = r^(12)
    return data.eps4*(data.sig12/r12 - data.sig6/r6)        
end            

function compute_forceij(coord, data::Data, )



end



### function example below
# Define LJ parameters
const ε = 1.0
const σ = 1.0
const cutoff_radius = 2.5σ

# Define simulation parameters
const num_particles = 100
const box_length = 10.0
const num_steps = 100
const time_step = 0.01

# Initialize particle positions and velocities
positions = box_length * rand(num_particles, 3)
velocities = zeros(num_particles, 3)

# Function to calculate LJ force and potential energy
function lj_force_potential(positions)
    forces = zeros(num_particles, 3)
    potential_energy = 0.0

    for i in 1:num_particles
        for j in (i+1):num_particles
            rij = positions[i, :] - positions[j, :]
            rij -= box_length * round(rij / box_length)  # Apply periodic boundary conditions

            r_sq = sum(rij.^2)
            if r_sq < cutoff_radius^2
                r = sqrt(r_sq)
                lj_potential = 4 * ε * ((σ / r)^12 - (σ / r)^6)
                lj_force = 24 * ε * ((2 * (σ / r)^13) - (σ / r)^7) * rij / r

                forces[i, :] += lj_force
                forces[j, :] -= lj_force
                potential_energy += lj_potential
            end
        end
    end

    return forces, potential_energy
end

## link with an example
# https://chat.openai.com/share/b78d955f-4546-4eb5-88a9-6d0b260de96c
