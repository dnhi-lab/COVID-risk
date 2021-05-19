function out = append_Ts_self_othe(in)

out.self = [in.self{1}; in.self{2}; in.self{3}];
out.diff = [in.diff{1}; in.diff{2}; in.diff{3}];

end
