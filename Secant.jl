""" Simple Secant Algorithm to find a root of a function f(x) in the interval [a,b]
    This is a simple secant algorithm that takes in a function and two initial guess
    and returns the root of the function.
    Args:
        f: function
        x0: First initial Approximation
        x1: Second initial Approximation
        tol: tolerance
        
    Returns:
        Iter: number of iterations
        xc: Root of the function
        AbsErr: absolute error
        RelErr: relative error
"""

# Import Packages

import Pkg

Pkg.add("Printf")
Pkg.add("Roots")
Pkg.add("Plots")
Pkg.add("LaTeXStrings")

# Load Packages

using Printf
using Roots
using LaTeXStrings
using Plots

# Define Function to be Rooted
# We considered f(x) = x²-2, x ∈ [0,2] with the solution x = 1.4142135623730951

function f(x)
    return x^2 - 2
end


function secant(f,x0,x1,tol)

    xold = x0;
    
    xc = x1 - (f(x1)*(x1-xold))/(f(x1)-f(xold));
    
    AbsErr = abs(xc-x0);
    
    RelErr = AbsErr/xc;

    i = 0;

    @printf("_______________________________________\n \n");
    @printf("k      Root     Abs Err    Rel Error    \n");
    @printf("_______________________________________\n \n");

    while abs(xc-xold) > tol;

        i += 1;

        xnew = xc - (f(xc)*(xc-xold))/(f(xc)-f(xold));
        
        AbsErr = abs(xnew-xold);
        
        RelErr =AbsErr/xnew;
        
        xold = xc;

        xc = xnew;


        @printf("%1.0f %1.9f %1.9f %1.9f \n", i, xc, AbsErr, RelErr)

    end

    return xc
    
end 

res = secant(f,0.0,2.0,1e-8)

k1 = find_zero(f, (0,2), Order1())

# Plot the function
x = range(0,stop=2,length=1000)
plot(x,f.(x),linewidth=3.0,xlabel=L"x",label=L"f(x)", legend=:topleft)
plot!([res],[0], markershape=:circle,markercolor=:red, markerstrokecolor=:black, markerstrokewidth=3,
	label= "Root",markersize=10)
plot!([k1],[0], markershape=:star,markercolor=:blue, markerstrokecolor=:black, markerstrokewidth=3,
	label= "Root by using Secant Method from Roots.jl",markersize=6)
