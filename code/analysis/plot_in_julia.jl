# %%
using Plots

x = -3:0.01:3
plot(x, sin.(x), label="sin(x)")
