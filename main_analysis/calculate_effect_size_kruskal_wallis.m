function eta_squared_H = calculate_effect_size_kruskal_wallis(H,k,n)

eta_squared_H = (H-k+1)/(n-k);

end
